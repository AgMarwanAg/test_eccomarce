// import 'package:flutter/material.dart';

// import '../dio_client/api_exception.dart';
// import 'state_widgets/failure_widget.dart';
// import 'state_widgets/loading_widget.dart';
// import 'state_widgets/no_data_widget.dart';

// class StateWidget extends StatelessWidget {
//   const StateWidget({
//     super.key,
//     required this.successWidget,
//     this.loadingWidget,
//     this.failureWidget,
//     this.emptyWidget,
//     this.isLoading = false,
//     this.isFailure = false,
//     this.isEmpty = false,
//     this.onRetry,
//     this.apiException,
//     this.isSuccess=false
//   });

//   final Widget successWidget;
//   final Widget? loadingWidget;
//   final Widget? failureWidget;
//   final Widget? emptyWidget;
//   final bool isLoading;
//   final bool isFailure;
//   final bool isEmpty;
//   final bool isSuccess;
//   final VoidCallback? onRetry;
//   final ApiException? apiException;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return loadingWidget ?? const LoadingWidget();
//     }
//     if (isFailure) {
//       return failureWidget ??
//           FailureWidget(
//             exception:
//                 apiException ?? ApiException(message: 'Something went wrong'),
//             onTap: onRetry,
//           );
//     }
//     if (isEmpty) {
//       return emptyWidget ?? const NoDataWidget();
//     }
//     if(isSuccess)return successWidget;
//     return  FailureWidget(
//             exception:
//                 apiException ?? ApiException(message: 'Something went wrong'),
//             onTap: onRetry,
//           );
//   }
// }
