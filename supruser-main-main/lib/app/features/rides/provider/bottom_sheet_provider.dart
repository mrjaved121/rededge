import 'package:flutter/material.dart';

class BottomSheetProvider extends ChangeNotifier {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool _isExpanded = false;

  DraggableScrollableController get controller => _controller;
  bool get isExpanded => _isExpanded;

  void initialize(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.isAttached) {
        _controller.jumpTo(0.3);
      }
    });

    _controller.addListener(() {
      if (_controller.isAttached) {
        final newExpandedState = _controller.size > 0.75;
        if (_isExpanded != newExpandedState) {
          _isExpanded = newExpandedState;
          notifyListeners();
        }
      }
    });
  }

  void toggleBottomSheet() {
    if (_controller.isAttached) {
      final targetSize = _isExpanded ? 0.3 : 1.0;
      _controller.animateTo(
        targetSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
