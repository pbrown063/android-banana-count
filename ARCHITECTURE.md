# 🏗️ Architecture Documentation

## Overview

This document outlines the architectural decisions made for the Android Banana Count application. The app is designed with simplicity, maintainability, and scalability in mind.

## Architecture Pattern: MVVM

### Decision Rationale

We chose **Model-View-ViewModel (MVVM)** as our architecture pattern for the following reasons:

1. **Separation of Concerns**: Clear separation between UI logic and business logic
2. **Testability**: ViewModels can be unit tested without Android framework dependencies
3. **Lifecycle Awareness**: ViewModels survive configuration changes (e.g., screen rotation)
4. **Android Recommended**: Official Google recommendation for Android apps
5. **Reactive Programming**: Natural fit with LiveData/StateFlow for reactive UI updates

### Architecture Layers

```
┌─────────────────────────────────────┐
│            View Layer               │
│  (Activity/Fragment/Composable)     │
│  - Displays UI                      │
│  - Handles user interactions        │
└──────────────┬──────────────────────┘
               │ observes
               ▼
┌─────────────────────────────────────┐
│         ViewModel Layer             │
│  - Holds UI state                   │
│  - Handles business logic           │
│  - Exposes data to View             │
└──────────────┬──────────────────────┘
               │ uses
               ▼
┌─────────────────────────────────────┐
│          Model Layer                │
│  - Data classes                     │
│  - Repository (if needed)           │
│  - Data sources                     │
└─────────────────────────────────────┘
```

## Component Decisions

### 1. UI Framework

**Decision**: Android Views (with potential migration to Jetpack Compose)

**Rationale**:
- **Android Views**: Mature, stable, well-documented
- **Future Consideration**: Jetpack Compose for modern declarative UI
- **Flexibility**: Easy to migrate incrementally if needed

**Trade-offs**:
- Views: More verbose XML, but familiar to most developers
- Compose: Modern and concise, but requires learning curve

### 2. State Management

**Decision**: StateFlow / LiveData

**Rationale**:
- **StateFlow**: Modern, coroutine-based, type-safe
- **LiveData**: Lifecycle-aware, prevents memory leaks
- **Reactive**: UI automatically updates when state changes

**Implementation**:
```kotlin
// ViewModel holds state
private val _bananaCount = MutableStateFlow(0)
val bananaCount: StateFlow<Int> = _bananaCount.asStateFlow()

// View observes state
viewModel.bananaCount.collect { count ->
    updateUI(count)
}
```

### 3. Data Persistence

**Decision**: SharedPreferences (for simple counter) or Room Database (for future expansion)

**Rationale**:
- **SharedPreferences**: Lightweight, perfect for simple key-value storage
- **Room**: Type-safe, SQL abstraction, better for complex data
- **Current Need**: Just storing a counter value

**Future Considerations**:
- If we add features like banana history, statistics, or multiple counters → migrate to Room
- If we need cloud sync → add Repository pattern with remote data source

### 4. Dependency Injection

**Decision**: Manual DI for now, Hilt for future scaling

**Rationale**:
- **Current Scope**: Simple app with minimal dependencies
- **Manual DI**: Sufficient for small apps, no overhead
- **Hilt**: Recommended when app grows, reduces boilerplate

**Migration Path**:
```kotlin
// Current: Manual injection
class MainActivity : AppCompatActivity() {
    private val viewModel = BananaViewModel()
}

// Future: Hilt injection
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private val viewModel: BananaViewModel by viewModels()
}
```

### 5. Threading & Coroutines

**Decision**: Kotlin Coroutines

**Rationale**:
- **Modern**: Kotlin-first approach to asynchronous programming
- **Readable**: Sequential code style for async operations
- **Lifecycle-Aware**: viewModelScope automatically cancels on ViewModel clear
- **Lightweight**: More efficient than threads

**Usage**:
```kotlin
fun incrementBananaCount() {
    viewModelScope.launch {
        // Async operations if needed
        _bananaCount.value++
        saveToPreferences()
    }
}
```

## Design Decisions

### 1. Single Activity Architecture

**Decision**: Single Activity with potential fragments

**Rationale**:
- **Simplicity**: App has one main screen
- **Navigation**: Easy to add Navigation Component if app grows
- **Modern**: Aligns with current Android best practices

### 2. Resource Management

**Decision**: Separate resources by type (drawable, string, dimen, color)

**Rationale**:
- **Maintainability**: Easy to find and update resources
- **Theming**: Centralized color and dimension values
- **Localization**: String resources support multiple languages

### 3. Error Handling

**Decision**: Graceful degradation with user feedback

**Rationale**:
- **User Experience**: Never crash, always inform user
- **Logging**: Use Timber for debug logging
- **Analytics**: Consider Firebase Crashlytics for production

## Testing Strategy

### Unit Tests
- **ViewModel Logic**: Test counter increment, state updates
- **Business Rules**: Validate any constraints (e.g., max count)
- **Framework**: JUnit 4/5, MockK for mocking

### UI Tests
- **User Flows**: Test button click → counter increment
- **Framework**: Espresso or Compose Testing
- **Coverage**: Critical user paths

### Integration Tests
- **Data Persistence**: Verify SharedPreferences/Room operations
- **End-to-End**: Full user scenarios

## Performance Considerations

1. **Memory**: ViewModel survives rotation, no memory leaks
2. **Rendering**: Efficient UI updates via StateFlow
3. **Battery**: No background services for this simple app
4. **APK Size**: Minimal dependencies, ProGuard for release builds

## Security Considerations

1. **Data Storage**: Counter value is not sensitive, SharedPreferences is acceptable
2. **Permissions**: No special permissions required
3. **Network**: No network calls (currently)

## Scalability Path

### Phase 1 (Current): Simple Counter
- Single screen, basic counter functionality

### Phase 2: Enhanced Features
- Multiple banana types
- Statistics and history
- Achievements/milestones

### Phase 3: Advanced Features
- Cloud sync
- Social sharing
- Widgets
- Wear OS support

## Technology Stack Summary

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| Language | Kotlin | Modern, concise, null-safe |
| Architecture | MVVM | Separation of concerns, testability |
| UI | Android Views | Stable, familiar |
| State | StateFlow | Reactive, coroutine-based |
| Async | Coroutines | Modern, efficient |
| Storage | SharedPreferences | Simple, sufficient |
| Testing | JUnit + Espresso | Standard Android testing |
| Build | Gradle (Kotlin DSL) | Type-safe build scripts |

## References

- [Android Architecture Guide](https://developer.android.com/topic/architecture)
- [MVVM Pattern](https://developer.android.com/topic/libraries/architecture/viewmodel)
- [Kotlin Coroutines](https://kotlinlang.org/docs/coroutines-overview.html)
- [Android Testing](https://developer.android.com/training/testing)

---

**Last Updated**: 2026-01-16  
**Version**: 1.0  
**Author**: pbrown063

