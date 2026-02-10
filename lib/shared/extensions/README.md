# Extensions Module

## Overview

The Extensions module provides a comprehensive collection of Dart extensions that enhance the functionality of built-in types like String, BuildContext, Widget, and more. These extensions improve code readability and provide convenient utility methods throughout the application.

## Available Extensions

### 1. String Extensions (`string_ex.dart`)
### 2. Context Extensions (`context_ex.dart`)
### 3. Padding Extensions (`padding_ex.dart`)
### 4. Widget Extensions (`widget_ex.dart`)
### 5. DateTime Extensions (`date_time_ex.dart`)
### 6. Size Extensions (`size_ex.dart`)
### 7. List Extensions (`list_ex.dart`)
### 8. Iterable Extensions (`iterable_ex.dart`)
### 9. Time Ago Extensions (`time_ago_ex.dart`)

## Import Usage

```dart
// Import all extensions at once
import 'package:incart/shared/extensions/_export.dart';

// Or import specific extensions
import 'package:incart/shared/extensions/string_ex.dart';
import 'package:incart/shared/extensions/context_ex.dart';
import 'package:incart/shared/extensions/padding_ex.dart';
```

## String Extensions

### NullableStringEx

Extensions for nullable strings (`String?`):

```dart
String? text = null;

// Check if null or empty
if (text.isEmptyOrNull) {
  print('Text is null or empty');
}

// Convert hex to color
String? hexColor = '#FF5733';
Color color = hexColor.toColor(); // Returns Color or Colors.transparent

// Check if valid image URL
String? imageUrl = 'https://example.com/image.jpg';
if (imageUrl.isImageUrl()) {
  // Load image
}

// Convert to DateTime
String? dateString = '2023-12-25T10:30:00Z';
DateTime? date = dateString.toDateTime();
```

### StringEx

Extensions for non-null strings:

```dart
// Number conversion
String price = '1,234.56';
double value = price.toDouble(); // Removes commas automatically
int intValue = '123'.toInt();

// Number validation
String input = 'abc123';
if (input.containsNumber) {
  print('Contains at least one digit');
}

// Time formatting
String time24 = '14:30';
String time12 = time24.to12HourFormat(); // '2:30 PM'

// Arabic number conversion
String arabicText = '١٢٣';
String englishText = arabicText.arToEnNumber(); // '123'

// Text validation
String email = 'user@example.com';
if (email.isEmail) {
  print('Valid email');
}

String phoneNumber = '5501234567';
if (phoneNumber.startsWithValidPhonePrefix()) {
  print('Valid Saudi phone number');
}

// Text manipulation
String longText = 'This is a very long text';
String shortText = longText.maxLength(10); // 'This is a '

String name = 'ahmed ali';
String formattedName = name.firstTwoWords(); // 'ahmed ali'

// Formatting
String number = '1234567.89';
String formatted = number.toThousandSeparated(); // '1,234,567.89'

// Extract date from ISO string
String isoDate = '2023-12-25T10:30:00Z';
String dateOnly = isoDate.extractDate(); // '2023-12-25'

// Convert to LatLng
String coordinates = '24.7136,46.6753';
LatLng location = coordinates.toLatLng(); // LatLng(24.7136, 46.6753)
```

## Context Extensions

Extensions for `BuildContext`:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Screen dimensions
    double screenWidth = context.width;
    double screenHeight = context.height;
    Size screenSize = context.size;
    
    // Device type detection
    if (context.isPhone) {
      return PhoneLayout();
    } else if (context.isTablet) {
      return TabletLayout();
    }
    
    // Keyboard handling
    if (context.isKeyboardOpen) {
      double keyboardHeight = context.keyboardBottomPadding;
      // Adjust UI for keyboard
    }
    
    // Status bar and padding
    double statusBarHeight = context.statusBarHeight;
    double bottomPadding = context.bottomPadding;
    
    // Focus management
    FocusNode focusNode = FocusNode();
    context.requestFocus(focusNode);
    context.unFocus(focusNode);
    
    // Ensure widget is visible (scroll to view)
    context.ensureVisible(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    
    return Container();
  }
}
```

## Padding Extensions

Extensions for adding padding to widgets:

```dart
// All sides padding
Text('Hello').paddingAll(16.0)

// Directional padding
Text('Hello').paddingVertical(8.0)
Text('Hello').paddingHorizontal(16.0)

// Symmetric padding
Text('Hello').paddingSymmetric(h: 16.0, v: 8.0)

// Specific sides
Text('Hello').paddingOnly(
  top: 8.0,
  start: 16.0,
  bottom: 8.0,
  end: 16.0,
)

// Individual sides
Text('Hello').paddingTop(16.0)
Text('Hello').paddingBottom(16.0)
Text('Hello').paddingStart(16.0)
Text('Hello').paddingEnd(16.0)

// Custom EdgeInsets
Text('Hello').padding(EdgeInsets.all(16.0))

// Chaining multiple extensions
Text('Hello')
  .paddingHorizontal(16.0)
  .paddingVertical(8.0)
```

## Widget Extensions

Extensions for widget enhancements:

```dart
// Visibility control
Text('Hello').visible(isVisible)
Text('Hello').invisible() // Makes widget invisible but keeps space
Text('Hello').gone() // Removes widget completely

// Flexible and Expanded
Text('Hello').flexible(flex: 2)
Text('Hello').expanded(flex: 1)

// Center alignment
Text('Hello').center()

// Clickable
Text('Hello').onTap(() {
  print('Tapped!');
})

// Loading overlay
Text('Hello').showLoading(isLoading)

// Shimmer effect
Text('Hello').shimmer(
  enabled: isLoading,
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
)
```

## DateTime Extensions

Extensions for DateTime manipulation:

```dart
DateTime now = DateTime.now();

// Formatting
String formatted = now.formatDate(); // '2023-12-25'
String timeFormat = now.formatTime(); // '10:30 AM'
String fullFormat = now.formatDateTime(); // '2023-12-25 10:30 AM'

// Relative time
String relative = now.timeAgo(); // 'Just now', '2 hours ago', etc.

// Date comparisons
DateTime yesterday = now.subtract(Duration(days: 1));
if (now.isSameDay(yesterday.add(Duration(days: 1)))) {
  print('Same day');
}

// Date arithmetic
DateTime startOfDay = now.startOfDay; // 00:00:00
DateTime endOfDay = now.endOfDay; // 23:59:59
DateTime startOfWeek = now.startOfWeek;
DateTime endOfWeek = now.endOfWeek;

// Age calculation
DateTime birthDate = DateTime(1990, 5, 15);
int age = birthDate.age; // Current age in years

// Is today/tomorrow/yesterday
if (now.isToday) {
  print('Today');
}
if (now.isTomorrow) {
  print('Tomorrow');
}
if (now.isYesterday) {
  print('Yesterday');
}
```

## Size Extensions

Extensions for size calculations:

```dart
// Screen-based sizes
double size = 20.0;

// Responsive sizing
double responsiveWidth = size.sw; // Screen width percentage
double responsiveHeight = size.sh; // Screen height percentage

// Text scaling
double scaledSize = size.sp; // Scaled pixel for text

// Responsive dimensions
double width = 100.w; // 100 logical pixels width
double height = 50.h; // 50 logical pixels height

// Min/Max responsive
double minSize = size.minSp; // Minimum scaled size
double maxSize = size.maxSp; // Maximum scaled size
```

## List Extensions

Extensions for List operations:

```dart
List<String> items = ['apple', 'banana', 'cherry'];

// Safe access
String? first = items.firstOrNull; // Returns null if empty
String? last = items.lastOrNull; // Returns null if empty
String? second = items.elementAtOrNull(1); // Safe element access

// Chunks and grouping
List<List<String>> chunks = items.chunked(2); // [['apple', 'banana'], ['cherry']]

// Distinct items
List<String> duplicates = ['apple', 'apple', 'banana'];
List<String> unique = duplicates.distinct(); // ['apple', 'banana']

// Conditional operations
List<String> fruits = items.whereNotNull(); // Remove null items
List<String> filtered = items.whereIndexed((index, item) => index > 0);

// Mapping with index
List<String> indexed = items.mapIndexed((index, item) => '$index: $item');

// Join with separator
String joined = items.joinWithSeparator(', '); // 'apple, banana, cherry'
```

## Iterable Extensions

Extensions for Iterable operations:

```dart
Iterable<int> numbers = [1, 2, 3, 4, 5];

// Mathematical operations
int sum = numbers.sum(); // 15
double average = numbers.average(); // 3.0
int max = numbers.maxValue(); // 5
int min = numbers.minValue(); // 1

// Conditional checks
if (numbers.all((n) => n > 0)) {
  print('All positive numbers');
}

if (numbers.any((n) => n > 3)) {
  print('Has number greater than 3');
}

// Safe operations
int? firstEven = numbers.firstWhereOrNull((n) => n % 2 == 0); // 2
int? lastOdd = numbers.lastWhereOrNull((n) => n % 2 == 1); // 5
```

## Time Ago Extensions

Extensions for relative time formatting:

```dart
DateTime past = DateTime.now().subtract(Duration(hours: 2));

// Relative time
String timeAgo = past.timeAgo(); // '2 hours ago'
String timeAgoShort = past.timeAgoShort(); // '2h'

// Localized time ago
String localizedTimeAgo = past.localizedTimeAgo(
  locale: 'ar', // Arabic
  short: false,
);

// Custom formatting
String customFormat = past.timeAgoCustom(
  justNow: 'الآن',
  minutesAgo: (min) => 'منذ $min دقيقة',
  hoursAgo: (hour) => 'منذ $hour ساعة',
);
```

## Best Practices

### 1. Use Extensions for Readability

```dart
// ✅ Good - Using extensions
String result = userInput
    .trim()
    .toUpperCase()
    .maxLength(50)
    .replaceAll(' ', '_');

// ❌ Bad - Without extensions
String input = userInput.trim();
input = input.toUpperCase();
if (input.length > 50) {
  input = input.substring(0, 50);
}
input = input.replaceAll(' ', '_');
```

### 2. Chain Extensions for Complex Operations

```dart
Widget buildCard(String title, bool isVisible) {
  return Card(
    child: Text(title),
  )
  .paddingAll(16.0)
  .visible(isVisible)
  .onTap(() => handleTap());
}
```

### 3. Use Null-Safe Extensions

```dart
// ✅ Good - Safe null handling
String? userInput = getUserInput();
if (!userInput.isEmptyOrNull) {
  // Process input
}

// ❌ Bad - Manual null checking
if (userInput != null && userInput.isNotEmpty) {
  // Process input
}
```

### 4. Leverage Context Extensions for Responsive UI

```dart
Widget buildResponsiveLayout(BuildContext context) {
  if (context.isPhone) {
    return buildPhoneLayout();
  } else if (context.isTablet) {
    return buildTabletLayout();
  } else {
    return buildDesktopLayout();
  }
}
```

## Performance Considerations

1. **Extension methods are static**: No performance overhead
2. **Chaining is efficient**: Extensions don't create intermediate objects
3. **Use context extensions carefully**: Some operations may trigger rebuilds
4. **Cache expensive computations**: Don't call context.size repeatedly

## Common Patterns

### Conditional Widget Display

```dart
Widget buildConditionalWidget(bool condition, String text) {
  return Text(text)
    .visible(condition)
    .paddingAll(16.0);
}
```

### Responsive Text Sizing

```dart
Widget buildResponsiveText(BuildContext context, String text) {
  double fontSize = context.isPhone ? 14.sp : 16.sp;
  
  return Text(
    text,
    style: TextStyle(fontSize: fontSize),
  ).paddingHorizontal(context.isPhone ? 16.0 : 24.0);
}
```

### Form Validation

```dart
String? validateEmail(String? input) {
  if (input.isEmptyOrNull) {
    return 'Email is required';
  }
  
  if (!input!.isEmail) {
    return 'Please enter a valid email';
  }
  
  return null;
}
```

### Safe Data Parsing

```dart
void parseApiResponse(Map<String, dynamic> json) {
  final priceString = json['price'] as String?;
  final price = priceString?.toDouble() ?? 0.0;
  
  final dateString = json['created_at'] as String?;
  final createdAt = dateString?.toDateTime() ?? DateTime.now();
}
```

These extensions significantly improve code readability, reduce boilerplate, and provide a consistent API across the application. They follow Dart conventions and integrate seamlessly with the existing codebase.