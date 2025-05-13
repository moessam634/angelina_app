import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollPageView extends StatefulWidget {
  final List<Widget> pages;
  final Duration interval;
  final bool loop;

  const AutoScrollPageView(
      {super.key,
      required this.pages,
      this.interval = const Duration(seconds: 3),
      this.loop = true});

  @override
  State<AutoScrollPageView> createState() => _AutoScrollPageViewState();
}

class _AutoScrollPageViewState extends State<AutoScrollPageView> {
  late final PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.interval, (timer) {
      if (_controller.hasClients) {
        if (_currentPage < widget.pages.length - 1) {
          _currentPage++;
        } else if (widget.loop) {
          _currentPage = 0;
        } else {
          _timer?.cancel();
          return;
        }

        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: widget.pages.length,
      itemBuilder: (context, index) => widget.pages[index],
    );
  }
}
