import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';

import 'core/di/locator.dart';
import 'package:flutter/material.dart';

import 'shared/cubits/session_cubit/session_cubit.dart';

/*
Adding all providers in this file is so wrong but it works.
*/

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SessionCubit>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
      ],
      child: child,
    );
  }
}
