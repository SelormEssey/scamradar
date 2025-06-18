# 🚨 ScamRadar

**ScamRadar** is a lightweight, community-driven scam reporting platform built for Ghana and beyond. It allows users to submit reports on suspicious phone numbers, usernames, or pages and check if a number or handle has been flagged before sending money. The long-term goal is to power scam detection with AI and help make mobile transactions safer across Africa.

---

## 🔍 Features

- ✅ Submit scam reports with MoMo number, username/page, description, and screenshot
- ✅ Real-time search for phone numbers or page handles
- ✅ Risk scoring logic (Low, Medium, High) based on report frequency
- ✅ Firebase backend (Firestore + Storage)
- 🔜 AI-powered scam detection engine (under development)
- 🔜 Country-based scam filtering and data validation

---

## 💡 Tech Stack

- **Frontend**: Flutter (Web + iOS compatible)
- **Backend**: Firebase Firestore & Firebase Storage
- **AI/ML (Planned)**: Python, Scikit-learn/TensorFlow for scam pattern recognition
- **Tools**: Git, Postman, VS Code

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Firebase account
- Dart CLI
- Firebase CLI (`flutterfire configure`)

### Clone and Run

```bash
git clone https://github.com/SelormEssey/scamradar.git
cd scamradar
flutter pub get
flutterfire configure
flutter run -d chrome
```

🧠 AI Vision (Phase 2)
ScamRadar will soon integrate an AI model trained on crowd-reported scams to:

Detect scam language in reports

Analyze usernames and social handles

Extract and evaluate text from screenshots

Return a confidence score with each report submission

🛡️ Security
Firestore rules are currently open for testing. Production deployment will require secure rules and basic authentication.

🤝 Contributing
Contributions are welcome! If you'd like to help with frontend features, AI models, or public data scraping, feel free to open an issue or contact me.

📫 Contact
Created by Selorm Essey
📧 sessey100@gmail.com
🌍 GitHub.com/SelormEssey

✅ License
This project is open-source under the MIT License.

yaml
Copy
