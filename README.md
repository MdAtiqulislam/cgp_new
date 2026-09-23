# TradeBar Customer (cgp_new)

The customer-side Flutter app for the TradeBar platform — browse, order, track and chat.

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
