# Shopping App

Flutter shopping app with API integration and real-time cart.

## 🛠 Tech
- **Flutter**: 3.35.1
- **State**: Provider
- **Storage**: SharedPreferences (Auth)

## 🚀 Setup & Run
1. `flutter pub get`
2. `flutter run`

## 🏗 Structure
- **Models**: Product, Category, Banner, Brand.
- **Services**: ApiService (Products), HomeService (Dashboard).
- **Logic**: Provider-based Controllers.
- **UI**: Login, Home, Product List, Details, Cart, Profile.

## 📝 Notes & Limitations
- **Cart**: In-memory only (resets on restart).
- **Images**: Dynamic network loading with fallback icons.
- **Auth**: Token-based; stored locally for session persistence.
- **Network**: Active internet required; no offline mode.

---
*Built with Flutter*
