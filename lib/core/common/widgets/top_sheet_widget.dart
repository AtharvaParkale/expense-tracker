import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class TopSheet {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context, Widget content) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => _TopSheetWidget(content: content),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _TopSheetWidget extends StatefulWidget {
  final Widget content;

  const _TopSheetWidget({required this.content});

  @override
  State<_TopSheetWidget> createState() => _TopSheetWidgetState();
}

class _TopSheetWidgetState extends State<_TopSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off-screen
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.3),
        child: GestureDetector(
          onTap: TopSheet.dismiss,
          child: Stack(
            children: [
              SlideTransition(
                position: _animation,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: AppPallete.whiteColor,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppDimensions.defaultPadding),
                      child: widget.content,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
