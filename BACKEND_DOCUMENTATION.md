# User Data Backend Implementation

## Overview
Created a backend system that manages and synchronizes user profile data across all relevant screens using a singleton UserService pattern with SharedPreferences persistence.

---

## Architecture

### 1. **UserModel** (`lib/models/user_model.dart`)
Data model representing a user with all profile information.

**Properties:**
```dart
- name: String
- email: String
- profileImagePath: String? (local file path)
- grade: String
- subjects: List<String>
- visualLearning: bool
- audioLearning: bool
- handsOnLearning: bool
```

**Key Methods:**
- `copyWith()` - Create modified copy for immutability
- `toJson()` - Convert to JSON for persistence
- `fromJson()` - Create from JSON
- `defaultUser()` - Factory for default user

---

### 2. **UserService** (`lib/services/user_service.dart`)
Singleton service managing user data globally with reactive updates.

**Features:**
- ✅ Singleton pattern for global access
- ✅ ChangeNotifier for reactive UI updates
- ✅ SharedPreferences persistence
- ✅ Complete CRUD operations
- ✅ Error handling

**Key Methods:**

```dart
// Initialization
Future<void> initialize() async
  - Loads user data from SharedPreferences on app startup

// Getters
String get name
String get email
String? get profileImagePath
List<String> get subjects
bool get visualLearning
// ... and more

// Update Methods
Future<void> updateName(String name)
Future<void> updateEmail(String email)
Future<void> updateProfileImagePath(String? imagePath)
Future<void> updateGrade(String grade)
Future<void> updateSubjects(List<String> subjects)
Future<void> addSubject(String subject)
Future<void> removeSubject(String subject)
Future<void> updateLearningPreferences({...})
Future<void> updateUserData({...})  // Update all at once

// Persistence
Future<void> _saveToPreferences()  // Auto-called after updates
Future<void> reset()  // Clear all data
```

**Usage Pattern:**
```dart
// Get the service
final userService = UserService();

// Load data
await userService.initialize();

// Listen to changes
userService.addListener(() {
  // Rebuild when data changes
  setState(() {});
});

// Update data
await userService.updateName('New Name');

// Read data
print(userService.name);

// Clean up
userService.removeListener(callback);
```

---

## Implementation in Screens

### 3. **main.dart** (Updated)
Initialize UserService on app startup.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize UserService
  final userService = UserService();
  await userService.initialize();
  
  runApp(const MainApp());
}
```

---

### 4. **EditProfileScreen** (Updated)
Saves all changes to UserService.

**Features:**
- Loads existing user data in `initState`
- Saves all changes when "Save Changes" button is tapped
- Shows success message and pops back
- Error handling with SnackBar

```dart
@override
void initState() {
  super.initState();
  final userService = UserService();
  nameController = TextEditingController(text: userService.name);
  emailController = TextEditingController(text: userService.email);
  // ... load other data
}

Future<void> _saveChanges() async {
  final userService = UserService();
  await userService.updateUserData(
    name: nameController.text,
    email: emailController.text,
    profileImagePath: profileImage?.path,
    grade: selectedGrade,
    subjects: selectedSubjects,
    visualLearning: visualLearning,
    audioLearning: audioLearning,
    handsOnLearning: handsOnLearning,
  );
  // Show success and pop
}
```

---

### 5. **HomeScreen** (Updated)
Displays and listens to user data changes.

```dart
@override
void initState() {
  super.initState();
  _userService = UserService();
  _loadUserData();
  _userService.addListener(_onUserDataChanged);
}

void _loadUserData() {
  setState(() {
    username = _userService.name;
    if (_userService.profileImagePath != null) {
      _profileImage = File(_userService.profileImagePath!);
    }
  });
}

void _onUserDataChanged() {
  _loadUserData();
}

@override
void dispose() {
  _userService.removeListener(_onUserDataChanged);
  super.dispose();
}
```

**Updates to display:**
- Profile picture in header (now shows picked image)
- Username in greeting
- Automatic updates when data changes

---

### 6. **SettingsScreen** (Updated)
Displays user data from UserService.

```dart
@override
void initState() {
  super.initState();
  _userService = UserService();
  _loadUserData();
  _userService.addListener(_onUserDataChanged);
}

void _loadUserData() {
  setState(() {
    if (_userService.profileImagePath != null) {
      _profileImage = File(_userService.profileImagePath!);
    }
  });
}

// Display data in profile header
Text(_userService.name)  // Shows updated name
Text(_userService.email)  // Shows updated email
```

**Updates to display:**
- User name
- User email
- Profile picture
- All sync with EditProfileScreen changes

---

## Data Flow

```
EditProfileScreen
       ↓
   (User saves)
       ↓
   UserService.updateUserData()
       ↓
   SharedPreferences.setString('user_data')
       ↓
   notifyListeners() [broadcasts to all listeners]
       ↓
   HomeScreen._onUserDataChanged() ─→ Updates UI
   SettingsScreen._onUserDataChanged() ─→ Updates UI
   (Any other listener)
```

---

## Data Persistence

### SharedPreferences Storage
```dart
Key: 'user_data'
Value: JSON String of UserModel
```

**Example stored JSON:**
```json
{
  "name": "Rahul Kumar",
  "email": "rahul@example.com",
  "profileImagePath": "/data/user/0/com.studybuddy/cache/image123.jpg",
  "grade": "Grade 10",
  "subjects": ["Physics", "Chemistry", "Math"],
  "visualLearning": true,
  "audioLearning": false,
  "handsOnLearning": true
}
```

### Persistence Behavior
- ✅ Data saved to SharedPreferences every time a field updates
- ✅ Data automatically loaded when app starts
- ✅ Survives app restart
- ✅ Can be reset with `userService.reset()`

---

## Usage Examples

### Update user profile from EditProfileScreen
```dart
await userService.updateUserData(
  name: 'John Doe',
  email: 'john@example.com',
  profileImagePath: '/path/to/image.jpg',
  grade: 'Grade 11',
  subjects: ['Physics', 'Math', 'Chemistry'],
  visualLearning: true,
  audioLearning: true,
  handsOnLearning: false,
);
```

### Listen to changes in any screen
```dart
_userService.addListener(() {
  setState(() {
    // Rebuild with new data
  });
});
```

### Access data anywhere
```dart
final userService = UserService();
print(userService.name);  // "John Doe"
print(userService.email);  // "john@example.com"
print(userService.subjects);  // ["Physics", "Math", "Chemistry"]
```

### Add/Remove single subject
```dart
await userService.addSubject('Biology');
await userService.removeSubject('Chemistry');
```

### Update only learning preferences
```dart
await userService.updateLearningPreferences(
  visualLearning: false,
  audioLearning: true,
);
```

---

## Testing Checklist

### Profile Image Sync
- [ ] Edit Profile → Select Image → Save Changes
- [ ] Navigate to Home screen → Verify image displays
- [ ] Navigate to Settings screen → Verify image displays
- [ ] Restart app → Verify image persists
- [ ] Try different images → Verify they update everywhere

### Name & Email Sync
- [ ] Edit Profile → Change name and email → Save
- [ ] Verify name shows on Home screen greeting
- [ ] Verify email shows on Settings screen
- [ ] Verify data persists after app restart

### Subjects Sync
- [ ] Edit Profile → Add/Remove subjects → Save
- [ ] Check that subject list is saved
- [ ] Verify persistence after app restart

### Learning Preferences Sync
- [ ] Edit Profile → Change learning preferences → Save
- [ ] Verify preferences are saved
- [ ] Verify they can be retrieved from UserService
- [ ] Verify persistence after app restart

### Complete Profile Sync
- [ ] Edit Profile → Change all fields → Save Changes
- [ ] Go to Home → Verify name and image updated
- [ ] Go to Settings → Verify name, email, and image updated
- [ ] Restart app → All data should persist

---

## File Structure

```
lib/
├── models/
│   └── user_model.dart (NEW)
├── services/
│   └── user_service.dart (NEW)
├── settings/
│   ├── settings_screen.dart (UPDATED)
│   └── edit_profile/
│       └── edit_profile_screen.dart (UPDATED)
├── features/
│   └── home/
│       └── screen/
│           └── home.dart (UPDATED)
└── main.dart (UPDATED)
```

---

## Key Features

✅ **Reactive Updates** - All screens update when data changes
✅ **Persistent Storage** - Data survives app restart
✅ **Singleton Pattern** - Single source of truth for user data
✅ **Type Safe** - Proper data models and type checking
✅ **Error Handling** - Try-catch blocks for safety
✅ **Memory Efficient** - Lazy listeners, proper cleanup
✅ **Scalable** - Easy to add new fields or screens
✅ **Encapsulated** - Clean separation of concerns

---

## Future Enhancements

1. **Backend API Integration**
   - Sync data with server
   - Handle network errors
   - Implement cloud backup

2. **Additional Features**
   - Profile history/versioning
   - Undo/Redo functionality
   - Batch updates
   - Data encryption for sensitive fields

3. **Performance**
   - Implement caching layer
   - Optimize JSON serialization
   - Add debouncing for frequent updates

4. **Testing**
   - Unit tests for UserModel
   - Integration tests for UserService
   - Widget tests for UI updates
