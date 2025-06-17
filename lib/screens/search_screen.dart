import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<DocumentSnapshot> results = [];
  bool isSearching = false;

  Future<void> searchReports() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      isSearching = true;
      results = [];
    });

    try {
      // Query by phone number
      final numberQuery = FirebaseFirestore.instance
          .collection('reports')
          .where('phoneNumber', isEqualTo: query)
          .get();

      // Query by username or page
      final usernameQuery = FirebaseFirestore.instance
          .collection('reports')
          .where('usernameOrPage', isEqualTo: query)
          .get();

      final resultsSet = await Future.wait([numberQuery, usernameQuery]);

      final allDocs = [
        ...resultsSet[0].docs,
        ...resultsSet[1].docs,
      ];

      setState(() {
        results = allDocs;
        isSearching = false;
      });
    } catch (e) {
      setState(() {
        isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching results')),
      );
    }
  }

  String getRiskLevel(int count) {
    if (count >= 5) return 'High Risk';
    if (count >= 2) return 'Medium Risk';
    return 'Low Risk';
  }

  Color getRiskColor(String level) {
    switch (level) {
      case 'High Risk':
        return Colors.red;
      case 'Medium Risk':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final riskLevel = getRiskLevel(results.length);
    final riskColor = getRiskColor(riskLevel);

    return Scaffold(
      appBar: AppBar(title: Text('Search a Number or Page')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter MoMo number or page handle',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchReports,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isSearching)
              CircularProgressIndicator()
            else if (results.isNotEmpty) ...[
              Text(
                '$riskLevel (${results.length} report${results.length > 1 ? 's' : ''})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final report = results[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(report['scamType'] ?? 'Unknown Scam'),
                        subtitle: Text(report['description'] ?? 'No description'),
                        trailing: Text(
                          report['phoneNumber'] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              )
            ] else
              Text('No reports found'),
          ],
        ),
      ),
    );
  }
}
