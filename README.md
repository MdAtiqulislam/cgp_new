# TradeBar Customer (cgp_new)

The customer-side Flutter app for the TradeBar platform — browse, order, track and chat.

[![Google Play](https://img.shields.io/badge/Google_Play-Download-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.tradebar.customer) [![App Store](https://img.shields.io/badge/App_Store-Download-0D96F2?style=for-the-badge&logo=app-store&logoColor=white)](https://apps.apple.com/app/id6730116636)


## Features

- Home, category search and location search
- Cart with floating cart button
- Address management (add/update delivery addresses)
- Live map view for tracking
- Auth: login and complete-registration flow
- Chat history, edit profile, FAQ page

## Tech Stack

- Flutter (Dart)
- GetX for state management and routing
- REST API backend

## Getting Started

```bash
flutter pub get
flutter run
```

Build a release APK:

```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── app/modules/   # Home, cart, search, map, auth, chat, profile
├── models/        # Data models
├── services/      # API and platform services
├── theme/         # App theme
└── main.dart      # App entry point
```

## Notes

- App label: "TradeBar Customer" (Android)
- No secrets or keystores are committed to this repository.
