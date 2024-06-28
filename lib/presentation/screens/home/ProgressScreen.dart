import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _progressTween;
  final _sortedItems = <ProgressItem>[];

  final List<ProgressItem> items = [];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
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
        _progressTween = Tween<double>(begin: 0, end: 1);
      });


      _updateSortedItems();

    });

    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _progressTween = Tween<double>(begin: 0, end: 1);
    _updateSortedItems();
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateSortedItems() {
    setState(() {
      _sortedItems
        ..clear()
        ..addAll(items)
        ..sort((a, b) => b.progress.compareTo(a.progress));
    });
  }

  @override
  void didUpdateWidget(covariant ProgressScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool hasUnsortedItems = items.any((item) => !_sortedItems.contains(item));
    if (hasUnsortedItems) {
      _updateSortedItems();
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

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

  // @override
  // bool get wantKeepAlive => true;
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
