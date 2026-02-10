import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/extensions/_export.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/double_press_back_widget.dart';
import '../features/home_tab/presentation/home_tab.dart';
import 'bottom_navigation_bar.dart';
import 'cubit/home_navigation_cubit.dart';
import 'floating_button_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String path = '/home';
  static const String name = 'home';
  const HomeScreen({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static void go(BuildContext context, {int? selectedIndex}) {
    context.go(path, extra: {'selectedIndex': selectedIndex});
  }

  static void push(BuildContext context) {
    context.push(path);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late List<Widget> _tabs;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabs = [
      HomeTab(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
    ];
  }

  /// This function is called when a bottom navigation bar item is tapped.
  /// It tells the PageController to animate to the corresponding page.
  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
    context.read<HomeNavigationCubit>().navigateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      onWillPop: context.watch<HomeNavigationCubit>().state == 0
          ? null
          : () async {
              if (context.read<HomeNavigationCubit>().state == 0) {
                return true;
              }
              context.read<HomeNavigationCubit>().navigateTo(0);
              return false;
            },

      // BlocListener is used to react to state changes from the Cubit,
      // like an external event forcing a tab change.
      child: BlocListener<HomeNavigationCubit, int>(
        listener: (context, state) {
          // If the cubit's state changes, we need to update the PageView.
          // This ensures that if navigation happens from somewhere else in the app,
          // the UI here will correctly jump to the right page.
          if (_pageController.page?.round() != state) {
            _pageController.jumpToPage(state);
          }
        },
        child: AppScaffold(
          withSafeArea: true,
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _tabs,
          ),
          bottomNavigationBar: context.isKeyboardOpen
              ? null
              : BlocBuilder<HomeNavigationCubit, int>(
                  builder: (context, selectedTab) {
                    return BottomNavigatorBarWidget(
                      selectedIndex: selectedTab,
                      onIndexChanged: _onTabTapped,
                    );
                  },
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
