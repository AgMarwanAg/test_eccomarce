import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/logging/logger.dart';
import 'text_widget.dart';

class CountdownTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback? onComplete;

  const CountdownTimer({
    super.key,
    required this.seconds,
    this.onComplete,
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late int remainingSeconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.seconds;
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        if (widget.onComplete != null) widget.onComplete!();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      remainingSeconds = widget.seconds;
    });
    startTimer();
  }

  bool get isCompleted => remainingSeconds <= 0;

  @override
  void dispose() {
    timer?.cancel();
    Logger.debug('timer disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      _formatTime(remainingSeconds),
      withLocale: false,
      // style: AppTextStyle.s16W300,
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
