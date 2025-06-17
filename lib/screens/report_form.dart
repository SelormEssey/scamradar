import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedScamType;
  File? selectedImage;

  final scamTypes = [
    'Rent Scam',
    'Job Scam',
    'Fake iPhone Seller',
    'Online Store Scam',
    'Lottery',
    'Other',
  ];

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void submit() {
    Navigator.pop(context, {
      'phone': phoneController.text.trim(),
      'username': usernameController.text.trim(),
      'scamType': selectedScamType ?? 'Other',
      'description': descriptionController.text.trim(),
      'image': selectedImage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report a Scam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'MoMo Number'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username/Page'),
            ),
            DropdownButtonFormField<String>(
              value: selectedScamType,
              items: scamTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedScamType = val),
              decoration: InputDecoration(labelText: 'Scam Type'),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'What happened?'),
            ),
            SizedBox(height: 10),
            selectedImage != null
                ? Image.file(selectedImage!, height: 150)
                : TextButton.icon(
                    onPressed: pickImage,
                    icon: Icon(Icons.upload),
                    label: Text('Upload Screenshot'),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
