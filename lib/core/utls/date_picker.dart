import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class CupertinoDatePickerWidget extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final CupertinoDatePickerMode mode;
  final ValueChanged<DateTime>? onDateTimeChanged;

  const CupertinoDatePickerWidget({
    super.key,
    this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.onDateTimeChanged,
  });

  @override
  State<CupertinoDatePickerWidget> createState() =>
      _CupertinoDatePickerWidgetState();
}

class _CupertinoDatePickerWidgetState extends State<CupertinoDatePickerWidget> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final minimumDate = widget.minimumDate ?? now;

    // Determine the initial date
    if (widget.initialDateTime != null &&
        !widget.initialDateTime!.isBefore(minimumDate)) {
      // Use provided initial date if it's not before minimum
      selectedDate = widget.initialDateTime!;
    } else {
      // Otherwise, use minimum date or a bit after it
      selectedDate = minimumDate.add(const Duration(minutes: 30));
    }
  }

  @override
  void didUpdateWidget(CupertinoDatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update selectedDate if initialDateTime changed and is valid
    if (widget.initialDateTime != oldWidget.initialDateTime &&
        widget.initialDateTime != null) {
      final minimumDate = widget.minimumDate ?? DateTime.now();
      if (!widget.initialDateTime!.isBefore(minimumDate)) {
        selectedDate = widget.initialDateTime!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: AppTextStyle.s16W600.copyWith(
              fontFamily: '',
              color: AppColors.primaryColor,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: widget.mode,
          use24hFormat: true,
          initialDateTime: selectedDate,
          minimumDate: widget.minimumDate,
          maximumDate: widget.maximumDate,
          showTimeSeparator: true,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => selectedDate = newDate);
            widget.onDateTimeChanged?.call(newDate);
          },
        ),
      ),
    );
  }
}
