// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class LayoutScaffold extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  final PreferredSizeWidget? customAppBar;
  final int? currentChildPageIndex;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Function? refreshScaffold;
  final bool topSafeArea;
  final bool extendBodyBehindAppBar;

  LayoutScaffold({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.currentChildPageIndex,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.customAppBar,
    this.topSafeArea = true,
    this.refreshScaffold,
    this.extendBodyBehindAppBar = false,
  });

  @override
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.customAppBar,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      extendBody: true,
      key: widget.key,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation ??
          FloatingActionButtonLocation.endFloat,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        top: widget.topSafeArea,
        child: widget.child,
      ),
    );
  }
}
