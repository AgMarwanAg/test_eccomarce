# Shared Widgets Module

## Overview

The Shared Widgets module provides a comprehensive collection of reusable UI components designed to maintain consistency, improve development efficiency, and ensure a cohesive user experience across the application. These widgets follow Material Design principles and are optimized for the application's design system.

## Features

- 🎨 **Consistent Design System**: All widgets follow the app's design tokens
- 📱 **Responsive**: Built with `flutter_screenutil` for responsive design
- 🌍 **Localized**: Integrated with `easy_localization` for multi-language support
- ♿ **Accessible**: Designed with accessibility in mind
- 🧪 **Testable**: Widget tests included following project specifications
- 🔄 **Reusable**: Highly configurable components for various use cases
- 🎭 **State Management**: Built-in loading, error, and success states

## Widget Categories

### 1. Layout & Structure
- [AppScaffold](#appscaffold) - Enhanced Scaffold with built-in padding and safe area
- [AppBorderWrapper](#appborderwrapper) - Container with consistent border styling
- [HorizontalList](#horizontallist) - Horizontal scrollable lists

### 2. Text & Typography
- [TextWidget](#textwidget) - Localized text with consistent styling

### 3. Buttons & Interactive
- [PrimaryBtn](#primarybtn) - Primary action buttons with loading states
- [SecondaryBtn](#secondarybtn) - Secondary action buttons
- [CircularButton](#circularbutton) - Circular icon buttons
- [ImageBtn](#imagebtn) - Image-based buttons
- [BackBtn](#backbtn) - Consistent back navigation

### 4. Form Controls
- [TextFieldWidget](#textfieldwidget) - Enhanced text input with validation
- [DropDownBtn](#dropdownbtn) - Dropdown selection component
- [SegmentedButtonWidget](#segmentedbuttonwidget) - Multi-option selection

### 5. Images & Media
- [NetWorkImageWidget](#networkimagewidget) - Network images with caching and error handling
- [AssetImageWidget](#assetimagewidget) - Local asset images
- [SvgAsset](#svgasset) - SVG image rendering
- [SvgNetwork](#svgnetwork) - Network SVG images

### 6. State Widgets
- [LoadingWidget](#loadingwidget) - Loading indicators
- [FailureWidget](#failurewidget) - Error state handling
- [NoDataWidget](#nodatawidget) - Empty state display

### 7. Navigation & App Bars
- [DefaultAppBar](#defaultappbar) - Standard app bar component
- [AddressAppBarWidget](#addressappbarwidget) - Location-aware app bar

### 8. Modals & Overlays
- [CustomBottomSheet](#custombottomsheet) - Configurable bottom sheets
- [CustomDialog](#customdialog) - Styled dialog components
- [AppToast](#apptoast) - Toast notifications

### 9. Animation & Effects
- [FadeInText](#fadeintext) - Text fade-in animations
- [ZoomInAnimation](#zoominanimation) - Zoom transition effects
- [AppSpinnerWidget](#appspinnerwidget) - Loading spinners
- [BlurWidget](#blurwidget) - Blur effects

### 10. Utility Widgets
- [BadgeWidget](#badgewidget) - Notification badges
- [DisableWidget](#disablewidget) - Conditional widget disabling
- [EmptyWidget](#emptywidget) - Placeholder widgets
- [DoublePressBackWidget](#doublepressbackwidget) - Double-tap to exit
- [CountDownWidget](#countdownwidget) - Timer countdowns
- [AppDividerWidget](#appdividerwidget) - Styled dividers

## Core Components

### AppScaffold

Enhanced Scaffold with built-in padding, safe area handling, and consistent styling.

```dart
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool centerTitle;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Widget? bottomSheet;
  final bool withSafeArea;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;
  final double padding;
}
```

**Usage:**
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: 'My Screen'),
      body: Column(
        children: [
          Text('Content goes here'),
          // Automatic horizontal padding applied
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### TextWidget

Localized text component with automatic translation and consistent styling.

```dart
class TextWidget extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  final Map<String, String>? namedArgs;
  final bool withLocale;
}
```

**Usage:**
```dart
// Basic usage with automatic localization
TextWidget('welcome_message')

// With custom styling
TextWidget(
  'user_name',
  style: AppTextStyle.s16W600,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
)

// With named arguments for translations
TextWidget(
  'welcome_user',
  namedArgs: {'name': 'Ahmed'},
)

// Without localization
TextWidget(
  'Raw text content',
  withLocale: false,
  style: TextStyle(fontSize: 14),
)
```

### PrimaryBtn

Primary action button with loading states, icons, and consistent styling.

```dart
class PrimaryBtn extends StatefulWidget {
  final Color? color;
  final String? text;
  final BorderRadius? borderRadius;
  final void Function()? onPressed;
  final double? width;
  final double height;
  final Widget? child;
  final String? icon;
  final bool disabled, isLoading;
  final TextStyle? textStyle;
}
```

**Usage:**
```dart
// Basic button
PrimaryBtn(
  text: 'save',
  onPressed: () => _handleSave(),
)

// With loading state
PrimaryBtn(
  text: 'submit',
  isLoading: _isSubmitting,
  onPressed: _isSubmitting ? null : () => _handleSubmit(),
)

// With icon
PrimaryBtn(
  text: 'add_to_cart',
  icon: 'assets/icons/cart.svg',
  onPressed: () => _addToCart(),
)

// Custom styling
PrimaryBtn(
  text: 'custom_action',
  color: Colors.green,
  borderRadius: BorderRadius.circular(20),
  height: 56,
  onPressed: () => _customAction(),
)

// Disabled state
PrimaryBtn(
  text: 'unavailable_action',
  disabled: true,
  onPressed: null,
)
```

### TextFieldWidget

Enhanced text input with validation, formatting, and consistent styling.

```dart
class TextFieldWidget extends StatefulWidget {
  final String? hintText, labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool? obscureText;
  final Function(String val)? onChanged;
  final Function(String val)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextAlign textAlign;
  final void Function()? onTap;
}
```

**Usage:**
```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email field
        TextFieldWidget(
          hintText: 'email_hint',
          labelText: 'email_label',
          controller: _emailController,
          focusNode: _emailFocus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: TextFieldValidator.validateEmail,
          prefixIcon: Icon(Icons.email),
          onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
        ),
        
        SizedBox(height: 16),
        
        // Password field
        TextFieldWidget(
          hintText: 'password_hint',
          labelText: 'password_label',
          controller: _passwordController,
          focusNode: _passwordFocus,
          obscureText: true,
          textInputAction: TextInputAction.done,
          validator: TextFieldValidator.validatePassword,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () => _togglePasswordVisibility(),
          ),
          onFieldSubmitted: (_) => _handleLogin(),
        ),
      ],
    );
  }
}
```

### NetWorkImageWidget

Network image component with caching, error handling, and loading states.

```dart
class NetWorkImageWidget extends StatelessWidget {
  final String? url;
  final bool? withGradient;
  final double? height;
  final Color? color;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final Border? border;
  final AlignmentGeometry? alignment;
  final bool withCaching;
  final EdgeInsetsGeometry? padding;
  final Widget? errorWidget;
}
```

**Usage:**
```dart
// Basic network image
NetWorkImageWidget(
  url: 'https://example.com/image.jpg',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)

// With caching disabled
NetWorkImageWidget(
  url: productImageUrl,
  withCaching: false,
  borderRadius: BorderRadius.circular(12),
)

// With custom error widget
NetWorkImageWidget(
  url: userAvatarUrl,
  width: 50,
  height: 50,
  borderRadius: BorderRadius.circular(25),
  errorWidget: Icon(
    Icons.person,
    size: 30,
    color: Colors.grey,
  ),
)

// Product card image
NetWorkImageWidget(
  url: product.imageUrl,
  height: 200,
  width: double.infinity,
  fit: BoxFit.cover,
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(12),
  ),
)
```

### FailureWidget

Error state widget with retry functionality and consistent error display.

```dart
class FailureWidget extends StatelessWidget {
  final ApiException exception;
  final GestureTapCallback? onTap;
  final double? topHeight;
  final bool? withCloseButton;
}
```

**Usage:**
```dart
// In a BlocBuilder
BlocBuilder<ProductsCubit, ProductsState>(
  builder: (context, state) {
    if (state is ProductsLoading) {
      return LoadingWidget();
    }
    
    if (state is ProductsError) {
      return FailureWidget(
        exception: state.exception,
        onTap: () => context.read<ProductsCubit>().loadProducts(),
      );
    }
    
    if (state is ProductsSuccess) {
      return ProductsList(products: state.products);
    }
    
    return NoDataWidget();
  },
)
```

## Form Validation

The module includes a comprehensive validation system:

```dart
class TextFieldValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr();
    }
    if (!value.isEmail) {
      return 'email_invalid'.tr();
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr();
    }
    if (value.length < 6) {
      return 'password_too_short'.tr();
    }
    return null;
  }
  
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone_required'.tr();
    }
    if (!value.startsWithValidPhonePrefix()) {
      return 'phone_invalid'.tr();
    }
    return null;
  }
}
```

## Advanced Usage Patterns

### Modal Bottom Sheets

```dart
// Show custom bottom sheet
void _showBottomSheet() {
  CustomBottomSheet.show(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            'select_option',
            style: AppTextStyle.s18W600,
          ),
          SizedBox(height: 20),
          ListTile(
            title: TextWidget('option_1'),
            onTap: () => _selectOption(1),
          ),
          ListTile(
            title: TextWidget('option_2'),
            onTap: () => _selectOption(2),
          ),
        ],
      ),
    ),
  );
}
```

### Custom Dialogs

```dart
// Show confirmation dialog
void _showConfirmationDialog() {
  CustomDialog.show(
    context: context,
    title: 'confirm_delete',
    content: 'delete_confirmation_message',
    actions: [
      SecondaryBtn(
        text: 'cancel',
        onPressed: () => Navigator.pop(context),
      ),
      PrimaryBtn(
        text: 'delete',
        color: Colors.red,
        onPressed: () {
          Navigator.pop(context);
          _performDelete();
        },
      ),
    ],
  );
}
```

### Toast Notifications

```dart
// Show success toast
AppToast.showSuccessToast(
  message: 'item_added_successfully',
);

// Show error toast
AppToast.showErrorToast(
  message: 'something_went_wrong',
);

// Show info toast
AppToast.showInfoToast(
  message: 'please_check_internet_connection',
  duration: Duration(seconds: 5),
);
```

### Animation Components

```dart
// Fade in text animation
FadeInText(
  'welcome_message',
  style: AppTextStyle.s24W700,
  duration: Duration(milliseconds: 800),
)

// Zoom in animation
ZoomInAnimation(
  child: NetWorkImageWidget(
    url: productImageUrl,
    width: 200,
    height: 200,
  ),
  duration: Duration(milliseconds: 500),
)
```

## Responsive Design

All widgets support responsive design using `flutter_screenutil`:

```dart
// Responsive button
PrimaryBtn(
  text: 'submit',
  height: 48.h, // Responsive height
  width: 200.w, // Responsive width
  onPressed: () {},
)

// Responsive text field
TextFieldWidget(
  hintText: 'enter_name',
  contentPadding: EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  ),
)

// Responsive image
NetWorkImageWidget(
  url: imageUrl,
  width: 150.w,
  height: 150.h,
  borderRadius: BorderRadius.circular(12.r),
)
```

## Testing

Following the project specification memory, each widget must include unit tests for business logic and widget tests for UI components:

### Widget Tests Example

```dart
// test/shared/widgets/text_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  group('TextWidget', () {
    testWidgets('displays text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextWidget('test_text', withLocale: false),
          ),
        ),
      );
      
      expect(find.text('test_text'), findsOneWidget);
    });
    
    testWidgets('applies custom style', (tester) async {
      const testStyle = TextStyle(fontSize: 20, color: Colors.red);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextWidget(
              'styled_text',
              withLocale: false,
              style: testStyle,
            ),
          ),
        ),
      );
      
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style, testStyle);
    });
    
    testWidgets('handles overflow correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 50,
              child: TextWidget(
                'Very long text that should overflow',
                withLocale: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
      
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });
  });
}
```

### Button Tests Example

```dart
// test/shared/widgets/primary_btn_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrimaryBtn', () {
    testWidgets('calls onPressed when tapped', (tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryBtn(
              text: 'Test Button',
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(PrimaryBtn));
      await tester.pump();
      
      expect(wasPressed, true);
    });
    
    testWidgets('shows loading spinner when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryBtn(
              text: 'Loading Button',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });
    
    testWidgets('is disabled when disabled property is true', (tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryBtn(
              text: 'Disabled Button',
              disabled: true,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(PrimaryBtn));
      await tester.pump();
      
      expect(wasPressed, false);
    });
  });
}
```

### Text Field Tests Example

```dart
// test/shared/widgets/text_field_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextFieldWidget', () {
    testWidgets('accepts text input', (tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWidget(
              controller: controller,
              hintText: 'Enter text',
            ),
          ),
        ),
      );
      
      await tester.enterText(find.byType(TextFormField), 'Test input');
      expect(controller.text, 'Test input');
    });
    
    testWidgets('validates input correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: TextFieldWidget(
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );
      
      // Submit empty form
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      
      // Trigger validation
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();
      
      expect(find.text('Required'), findsOneWidget);
    });
  });
}
```

### BlocTest for State Management

For widgets that interact with Cubits/Blocs, use BlocTest:

```dart
// test/shared/widgets/failure_widget_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockDataCubit extends MockCubit<DataState> implements DataCubit {}

void main() {
  group('FailureWidget', () {
    late MockDataCubit mockCubit;
    
    setUp(() {
      mockCubit = MockDataCubit();
    });
    
    testWidgets('displays error message and retry button', (tester) async {
      final exception = ApiException(
        message: 'Network error',
        statusCode: 500,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<DataCubit>(
              create: (_) => mockCubit,
              child: FailureWidget(
                exception: exception,
                onTap: () => mockCubit.loadData(),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Network error'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('reload'), findsOneWidget);
    });
    
    testWidgets('calls retry function when retry button is tapped', (tester) async {
      final exception = ApiException(message: 'Error', statusCode: 400);
      bool retryWasCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FailureWidget(
              exception: exception,
              onTap: () => retryWasCalled = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.text('reload'));
      await tester.pump();
      
      expect(retryWasCalled, true);
    });
  });
}
```

## Best Practices

### 1. Consistent Widget Usage

```dart
// ✅ Good - Use TextWidget for all text
TextWidget(
  'user_name',
  style: AppTextStyle.s16W600,
)

// ❌ Bad - Direct Text widget
Text(
  'User Name', // Not localized
  style: TextStyle(fontSize: 16), // Inconsistent styling
)
```

### 2. Proper State Management

```dart
// ✅ Good - Handle all states
BlocBuilder<DataCubit, DataState>(
  builder: (context, state) {
    if (state is DataLoading) {
      return LoadingWidget();
    }
    if (state is DataError) {
      return FailureWidget(
        exception: state.exception,
        onTap: () => context.read<DataCubit>().loadData(),
      );
    }
    if (state is DataSuccess) {
      return DataList(data: state.data);
    }
    return NoDataWidget();
  },
)
```

### 3. Responsive Design

```dart
// ✅ Good - Use responsive units
Container(
  width: 200.w,
  height: 100.h,
  padding: EdgeInsets.all(16.r),
  child: TextWidget(
    'content',
    style: AppTextStyle.s14W400,
  ),
)

// ❌ Bad - Fixed dimensions
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
)
```

### 4. Form Validation

```dart
// ✅ Good - Use provided validators
TextFieldWidget(
  controller: emailController,
  validator: TextFieldValidator.validateEmail,
  keyboardType: TextInputType.emailAddress,
)

// ❌ Bad - Custom validation without reuse
TextFormField(
  validator: (value) {
    // Custom validation logic that could be reused
  },
)
```

### 5. Image Loading

```dart
// ✅ Good - Use NetWorkImageWidget with error handling
NetWorkImageWidget(
  url: imageUrl,
  width: 100,
  height: 100,
  errorWidget: Icon(Icons.image_not_supported),
)

// ❌ Bad - Direct Image.network without error handling
Image.network(imageUrl) // No error handling or loading states
```

### 6. Memory Management

```dart
// ✅ Good - Proper disposal
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
```

## Performance Considerations

1. **Image Caching**: NetWorkImageWidget automatically caches images
2. **Widget Rebuilds**: Use const constructors where possible
3. **Memory Management**: Dispose controllers and focus nodes properly
4. **Loading States**: Always provide loading indicators for async operations
5. **Responsive Scaling**: Use flutter_screenutil for consistent sizing

## Common Patterns

### Screen Template

```dart
class FeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: 'feature_title'),
      body: BlocBuilder<FeatureCubit, FeatureState>(
        builder: (context, state) {
          if (state is FeatureLoading) {
            return LoadingWidget();
          }
          
          if (state is FeatureError) {
            return FailureWidget(
              exception: state.exception,
              onTap: () => context.read<FeatureCubit>().loadData(),
            );
          }
          
          if (state is FeatureSuccess) {
            return RefreshIndicator(
              onRefresh: () => context.read<FeatureCubit>().refresh(),
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return FeatureListItem(item: state.items[index]);
                },
              ),
            );
          }
          
          return NoDataWidget();
        },
      ),
    );
  }
}
```

### Form Dialog

```dart
void showFormDialog(BuildContext context) {
  CustomDialog.show(
    context: context,
    title: 'add_item',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldWidget(
          hintText: 'item_name',
          validator: TextFieldValidator.validateRequired,
        ),
        SizedBox(height: 16),
        TextFieldWidget(
          hintText: 'item_description',
          maxLines: 3,
        ),
      ],
    ),
    actions: [
      SecondaryBtn(
        text: 'cancel',
        onPressed: () => Navigator.pop(context),
      ),
      PrimaryBtn(
        text: 'save',
        onPressed: () => _handleSave(context),
      ),
    ],
  );
}
```

### Loading Button Pattern

```dart
class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  
  const SubmitButton({
    Key? key,
    required this.isLoading,
    this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return PrimaryBtn(
      text: 'submit',
      isLoading: isLoading,
      disabled: isLoading,
      onPressed: isLoading ? null : onPressed,
    );
  }
}
```

## Migration Guide

### From Basic Flutter Widgets

```dart
// Before - Basic Flutter widgets
Scaffold(
  appBar: AppBar(title: Text('Screen Title')),
  body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Hello'),
        ElevatedButton(
          onPressed: () {},
          child: Text('Submit'),
        ),
      ],
    ),
  ),
)

// After - Shared widgets
AppScaffold(
  appBar: DefaultAppBar(title: 'screen_title'),
  body: Column(
    children: [
      TextWidget('hello'),
      PrimaryBtn(
        text: 'submit',
        onPressed: () {},
      ),
    ],
  ),
)
```

## Widget Catalog

### Complete Button Collection

| Widget | Use Case | Example |
|--------|----------|---------|
| PrimaryBtn | Main actions | Save, Submit, Continue |
| SecondaryBtn | Secondary actions | Cancel, Skip, Back |
| CircularButton | Icon actions | FAB, Icon buttons |
| ImageBtn | Image-based actions | Social login, Gallery |
| BackBtn | Navigation | Screen back button |

### State Widget Collection

| Widget | Use Case | When to Use |
|--------|----------|-------------|
| LoadingWidget | Data loading | API calls, async operations |
| FailureWidget | Error states | Network errors, API failures |
| NoDataWidget | Empty states | Empty lists, no search results |

### Form Widget Collection

| Widget | Use Case | Input Type |
|--------|----------|------------|
| TextFieldWidget | Text input | Text, email, password |
| DropDownBtn | Selection | Single choice from list |
| SegmentedButtonWidget | Multiple choice | Filter options, categories |

This comprehensive widget library ensures consistency, maintainability, and excellent user experience across the application while following Flutter best practices and the project's design system.
```
```