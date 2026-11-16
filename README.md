# PickMe – Smart Trip Planner ✈️

**PickMe** is a smart trip planning mobile application built with Flutter. It helps users create personalized trip plans based on their destination, available budget, and interests.

Instead of manually searching for places and calculating expenses, users can enter their budget, choose their preferred categories, and receive up to three suggested trip plans.

The application uses real data stored in Supabase to generate suitable plans.

---

## ✨ Features

### 👤 User Features
- **User Authentication:** Register and log in using email and password.
- **Destination Selection:** Choose between Cairo, Alexandria, and Sharm El Sheikh.
- **Budget Management:** Set a personal budget for the trip.
- **Category Selection:** Choose preferred activities and places.
- **Smart Trip Planning:** Generate up to three trip plans based on the selected destination, budget, and categories.
- **Trip Details:** View selected places, estimated costs, and budget breakdown.

### 🛠️ Admin Features
- **Manage Places:** Add new places to the application.
- **Update Places:** Edit existing place information.
- **Delete Places:** Remove places from the database.
- **Manage Trip Data:** Maintain the places and information used by the trip planning system.

---

## 📍 Available Destinations

- Cairo
- Alexandria
- Sharm El Sheikh

## 🧩 Available Categories

- Historical Places
- Food & Street Eats
- Entertainment & Leisure
- Beaches & Watersports
- Nature & Parks
- Souks & Shopping

---

## 🛠️ Technologies Used

- **Flutter** – Cross-platform mobile application development.
- **Dart** – Programming language.
- **Supabase** – Backend and database.
- **Supabase Authentication** – User authentication.
- **Flutter Bloc (Cubit)** – State management.

---

## 📸 Screenshots



### Splash & Authentication
<!-- Add screenshots here -->
![Sign In Screen](screenshots/signin.png)

![Sign Up Screen](screenshots/signup.png)


### User Trip Planning
<!-- Add screenshots here -->
![Home Screen](screenshots/home.png)

![Budget Screen](screenshots/budget.png)

![Plans Screen](screenshots/plans.png)

![Details Screen](screenshots/details.png)

![Confirm Dialog](screenshots/confirm.png)


### Admin
<!-- Add screenshots here -->

![Admin Dashboard](screenshots/admin.png)

---

## 🗂️ Project Structure

```text
lib/
├── core/
│   └── config/
├── features/
│   ├── admin/
│   ├── auth/
│   ├── home/
│   └── trip_planning/
│       ├── data/
│       │   ├── models/
│       │   └── repos/
│       ├── logic/
│       │   ├── cubit/
│       │   └── planner_service.dart
│       └── presentation/
│           ├── screens/
│           └── widgets/
├── main.dart
└── pick_me_app.dart
```

---

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- A Supabase project

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ranawael15/pickMe.git
```

2. Navigate to the project directory:

```bash
cd pickMe
```

3. Install dependencies:

```bash
flutter pub get
```

4. Configure your Supabase credentials securely.

5. Run the application:

```bash
flutter run
```

---

## 📱 Build APK

To generate a release APK, run:

```bash
flutter build apk --release
```

The generated APK will be available at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🔐 Security

- Never upload private API keys, passwords, or Supabase `service_role` keys to a public repository.
- Configure appropriate Supabase Row Level Security (RLS) policies.
- Use safe configuration practices for application credentials.

---

## 👩‍💻 Team Members

This project was developed by:

- **Sara Ahmed**
- **Solav Amer**
- **Ruqaya Ahmed**
- **Rana Wael**

---

## ❤️ Acknowledgment

Thank you for checking out PickMe!

Made with Flutter and ❤️.