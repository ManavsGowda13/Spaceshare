# 🚀 SpaceShare

A modern **Flutter-based Smart Space & Resource Booking System** designed for educational institutions.  
SpaceShare enables students and faculty to efficiently manage and visualize shared academic resources through an elegant glassmorphism-powered interface.

---

## ✨ Features

- 📅 Smart classroom & lab booking system
- 🔍 Real-time search and filtering
- 📊 Interactive occupancy heatmaps
- 👨‍🏫 Faculty administration dashboard
- 🔐 Role-based login system
- 🎨 Glassmorphism-inspired modern UI
- 📱 Fully responsive across Android, iOS, and Web

---

## 🛠️ Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Naveenr810953/SpaceShare.git
```

### 2️⃣ Navigate to the Project Directory

```bash
cd SpaceShare
```

### 3️⃣ Download Package Dependencies

```bash
flutter pub get
```

### 4️⃣ Run the Application

```bash
flutter run
```

---

# 📁 Project Structure

```plaintext
SpaceShare/
├── lib/
│   ├── models/
│   │   └── resource_model.dart
│   │       # Data blueprints and asset arrays
│   │
│   ├── screens/
│   │   ├── space_admin.dart
│   │   │   # Faculty provisioning dashboard
│   │   │
│   │   ├── space_dashboard.dart
│   │   │   # Student booking grid, search, & heatmap
│   │   │
│   │   └── space_login.dart
│   │       # Role-based credential router
│   │
│   └── main.dart
│       # Core system entry and routing table
│
├── pubspec.yaml
│   # System package dependencies configuration
│
└── README.md
    # Documentation
```

---

# 🌐 Platform Compatibility

| Platform | Support | Notes |
|----------|----------|-------|
| Android | ✅ | Full support, tested on SDK 34 |
| iOS | ✅ | Full support with Cupertino styles |
| Web | ✅ | Responsive grid scaling supported |

---

# 🔧 Technologies Used

- **Flutter SDK** – Cross-platform application framework
- **Dart** – State management and UI logic
- **Glassmorphism UI** – Semi-transparent layered interface design
- **Google Fonts (Inter)** – Modern typography rendering

---

# 🎨 Customization

You can directly customize dashboard visuals and layout behavior.

## 📊 Heatmap Density

Modify the `_densityMatrix` inside `space_dashboard.dart`:

```dart
final List<List<int>> _densityMatrix = [
  [0, 0, 0, 0], // Monday completely free
];
```

### Density Values

| Value | Meaning |
|------|---------|
| 0 | Free Slot (Teal) |
| 1 | Low Occupancy |
| 2 | Medium Occupancy |
| 3 | Fully Occupied |

---

## 📐 Grid Density

Modify the `childAspectRatio` value inside the `GridView.builder`:

```dart
childAspectRatio: 0.95
```

This changes dashboard tile proportions and spacing.

---

# 🤝 Contributing

Contributions are welcome!

## Steps to Contribute

1. Fork the repository
2. Create a feature branch

```bash
git checkout -b feature/AmazingFeature
```

3. Commit your changes

```bash
git commit -m "Add some AmazingFeature"
```

4. Push to your branch

```bash
git push origin feature/AmazingFeature
```

5. Open a Pull Request

---

# 📝 TODO List

- [ ] Add persistent local storage using Hive or Shared Preferences
- [ ] Integrate live barcode/QR scanning
- [ ] Push notifications for booking reminders
- [ ] Runtime dark/light mode switching
- [ ] Firebase backend integration
- [ ] Analytics dashboard for administrators

---

# 📊 Performance Optimizations

- ⚡ Localized `setState()` re-render handling
- ⚡ Lazy-loaded `GridView.builder`
- ⚡ Optimized memory-safe modal transitions
- ⚡ Lightweight data schema management

---

# 🙏 Acknowledgments

- Glassmorphism UI open-source maintainers
- Google Fonts typography team
- Inspired by modern academic resource optimization systems

---

# ⭐ Support

If you like this project, consider giving it a **star ⭐ on GitHub**!

---
