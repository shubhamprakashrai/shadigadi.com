import 'package:flutter/material.dart';
import '../widgets/common_appbar.dart';
import '../widgets/common_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool showBottomNav;
  final int currentIndex;
  final Function(int)? onNavItemTapped;

  const MainLayout({
    Key? key,
    required this.child,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.showBottomNav = true,
    this.currentIndex = 0,
    this.onNavItemTapped,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: widget.title,
        showBackButton: widget.showBackButton,
        actions: widget.actions,
      ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: widget.showBottomNav
          ? CommonBottomNav(
              currentIndex: widget.currentIndex,
              onTap: widget.onNavItemTapped ?? (_) {},
            )
          : null,
    );
  }
}
