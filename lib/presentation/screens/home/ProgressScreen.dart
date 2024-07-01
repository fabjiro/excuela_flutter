import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Tween<double> _progressTween;
  final _sortedItems = <ProgressItem>[];

  final List<ProgressItem> items = [];

  @override
  /// Initialize the state of the [_ProgressScreenState] class.
  ///
  /// This method is called when the widget is first created and inserted into
  /// the tree. It initializes the [_animationController], [_progressTween], and
  /// [_sortedItems] lists. After a 2-second delay, it adds some sample
  /// [ProgressItem]s to the [_items] list and updates the UI. It also starts
  /// the animation controller.
  @override
  void initState() {
    super.initState();

    // Delay the initialization of the [_items] list by 2 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        // Add sample items to the [_items] list
        items.addAll([
          ProgressItem(
            color: Colors.red,
            progress: 0.4,
          ),
          ProgressItem(
            color: Colors.green,
            progress: 0.2,
          ),
          ProgressItem(
            color: Colors.blue,
            progress: 1,
          ),
        ]);

        // Set the initial values for the [_progressTween] animation
        _progressTween = Tween<double>(begin: 0, end: 1);
      });

      // Update the sorted items list
      _updateSortedItems();
    });

    // Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Set the initial values for the [_progressTween] animation
    _progressTween = Tween<double>(begin: 0, end: 1);

    // Update the sorted items list
    _updateSortedItems();

    // Start the animation controller
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Updates the sorted items list by clearing the current list and adding
  /// all items from the [items] list. Then sorts the list in descending order
  /// based on the progress of each item.
  ///
  /// This method is called when the state of the widget needs to be updated.
  void _updateSortedItems() {
    // Clear the current sorted items list
    setState(() {
      _sortedItems.clear();

      // Add all items from the [items] list to the sorted items list
      _sortedItems.addAll(items);

      // Sort the sorted items list in descending order based on the progress
      // of each item
      _sortedItems.sort((a, b) => b.progress.compareTo(a.progress));
    });
  }

  @override
  /// Updates the state of the widget when the widget is updated.
  ///
  /// Checks if there are any items that are not sorted and if so, updates the
  /// sorted items list and starts the animation controller from the beginning.
  @override
  void didUpdateWidget(covariant ProgressScreen oldWidget) {
    // Call the parent class's didUpdateWidget method
    super.didUpdateWidget(oldWidget);

    // Check if there are any items that are not sorted
    bool hasUnsortedItems = items.any(
      (item) => !_sortedItems.contains(item),
    );

    // If there are unsortered items, update the sorted items list and start the
    // animation controller from the beginning
    if (hasUnsortedItems) {
      _updateSortedItems();
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 32,
          start: 20,
          end: 20,
          bottom: 15,
        ),
        child: SizedBox(
          height: 130,
          width: 260,
          child: AnimatedBuilder(
            animation: CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeIn,
            ),
            builder: (BuildContext context, Widget? child) {
              final progress = _progressTween.evaluate(_animationController);

              return CustomPaint(
                painter: _BackgroundPainter(),
                foregroundPainter: _ForegroundPainter(
                  _sortedItems,
                  overriddenProgress: progress,
                ),
                isComplex: true,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ForegroundPainter extends CustomPainter {
  _ForegroundPainter(this.items, {this.overriddenProgress = 1});

  final List<ProgressItem> items;
  final double overriddenProgress;

  @override
  void paint(Canvas canvas, Size size) {
    for (final item in items) {
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 20;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height),
          radius: size.width / 2,
        ),
        pi,
        pi *
            2 /
            2 *
            (overriddenProgress < item.progress
                ? overriddenProgress
                : item.progress),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height),
        radius: size.width / 2,
      ),
      pi,
      2 * pi / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProgressItem {
  ProgressItem({
    required this.progress,
    this.color = Colors.black,
  });

  final Color color;
  final double progress;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressItem &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          progress == other.progress;

  @override
  int get hashCode => color.hashCode ^ progress.hashCode;
}
