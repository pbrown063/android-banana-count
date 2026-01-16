# 🍌 Android Banana Count

A simple, delightful Android application that lets you count bananas! Tap the banana button to increment your banana count.

## 📱 Features

- **Banana Display**: Visual banana representation
- **Interactive Button**: Tap to count bananas
- **Counter Display**: Real-time banana count tracking
- **Simple & Intuitive**: Clean, user-friendly interface

## 🚀 Getting Started

### Prerequisites

- Android Studio (Arctic Fox or later recommended)
- Android SDK (API Level 21+)
- Kotlin 1.5+
- Gradle 7.0+

### Installation

1. Clone the repository:
```bash
git clone git@github.com:pbrown063/android-banana-count.git
cd android-banana-count
```

2. Open the project in Android Studio

3. Sync Gradle files

4. Run the app on an emulator or physical device

## 🏗️ Architecture

This app follows modern Android development best practices. For detailed architecture decisions, see [ARCHITECTURE.md](ARCHITECTURE.md).

### Key Technologies

- **Language**: Kotlin
- **UI Framework**: Android Views / Jetpack Compose (TBD)
- **Architecture Pattern**: MVVM (Model-View-ViewModel)
- **State Management**: LiveData / StateFlow
- **Dependency Injection**: Hilt (optional)

## 📂 Project Structure

```
android-banana-count/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/pbrown/bananacount/
│   │   │   │   ├── ui/           # UI components
│   │   │   │   ├── viewmodel/    # ViewModels
│   │   │   │   ├── model/        # Data models
│   │   │   │   └── MainActivity.kt
│   │   │   ├── res/              # Resources (layouts, drawables, etc.)
│   │   │   └── AndroidManifest.xml
│   │   └── test/                 # Unit tests
│   └── build.gradle
├── ARCHITECTURE.md
└── README.md
```

## 🎯 Usage

1. Launch the app
2. See the banana display
3. Tap the banana button
4. Watch your banana count increase!
5. Keep tapping to count more bananas 🍌

## 🧪 Testing Locally

### Quick Start (Linux)

Run the app on an emulator:
```bash
./run-emulator.sh
```

This script will:
1. Start the Android emulator (Pixel 5 API 34)
2. Build the app
3. Install it on the emulator
4. Launch the app automatically

### Manual Testing

Build the app:
```bash
export ANDROID_HOME=~/Android/Sdk
./gradlew assembleDebug
```

Install on connected device/emulator:
```bash
./gradlew installDebug
```

### Unit Tests

Run unit tests:
```bash
./gradlew test
```

Run instrumented tests:
```bash
./gradlew connectedAndroidTest
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**pbrown063**
- GitHub: [@pbrown063](https://github.com/pbrown063)

## 🙏 Acknowledgments

- Inspired by the joy of counting bananas
- Built with ❤️ and Kotlin

---

**Happy Banana Counting! 🍌**

