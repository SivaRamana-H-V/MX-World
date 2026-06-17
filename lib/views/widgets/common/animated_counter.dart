import 'package:flutter/material.dart';

/// An animated counter that reveals each digit with a rolling odometer effect.
///
/// - Individual digits slide from 0 to their target value vertically.
/// - Each digit has a staggered delay for a cascading entrance.
/// - Non-numeric characters (commas, periods, suffixes) render statically.
/// - The entire counter bounces in with a subtle scale animation.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(seconds: 2),
    this.staggerDelay = const Duration(milliseconds: 60),
  });

  final String value;
  final TextStyle? style;
  final Duration duration;
  final Duration staggerDelay;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late final AnimationController _digitController;
  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnim;

  final List<Animation<double>> _digitAnims = [];
  final List<_CharKind> _chars = [];
  int _digitCount = 0;

  bool _started = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _parseValue();
    _digitController =
        AnimationController(vsync: this, duration: _totalDuration);
    _bounceController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _bounceAnim =
        CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut);
    _initDigitAnims();
    _checkVisibility();
  }

  Duration get _totalDuration {
    if (_digitCount <= 1) return widget.duration;
    return widget.duration + widget.staggerDelay * (_digitCount - 1);
  }

  void _parseValue() {
    _chars.clear();
    _digitCount = 0;
    for (int i = 0; i < widget.value.length; i++) {
      final c = widget.value[i];
      final code = c.codeUnitAt(0);
      if (code >= 0x30 && code <= 0x39) {
        _chars.add(_CharKindDigit(int.parse(c), _digitCount));
        _digitCount++;
      } else {
        _chars.add(_CharKindText(c));
      }
    }
  }

  void _initDigitAnims() {
    _digitAnims.clear();
    if (_digitCount == 0) return;
    final totalMs = _totalDuration.inMilliseconds;
    for (int i = 0; i < _digitCount; i++) {
      final startMs = widget.staggerDelay.inMilliseconds * i;
      final endMs = startMs + widget.duration.inMilliseconds;
      _digitAnims.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _digitController,
            curve: Interval(
              startMs / totalMs,
              (endMs / totalMs).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          ),
        ),
      );
    }
  }

  void _checkVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _findScrollable();
      _maybeStart();
    });
  }

  void _findScrollable() {
    context.visitAncestorElements((element) {
      if (element.widget is Scrollable) {
        final scrollable = element.widget as Scrollable;
        final physics = scrollable.physics;
        if (physics == null || physics is! NeverScrollableScrollPhysics) {
          final stateElement = element as StatefulElement;
          _scrollPosition = (stateElement.state as ScrollableState).position;
          _scrollPosition!.addListener(_onScroll);
          return false;
        }
      }
      return true;
    });
  }

  void _onScroll() => _maybeStart();

  void _maybeStart() {
    if (_started || !mounted) return;
    final object = context.findRenderObject();
    if (object is! RenderBox || !object.attached) return;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final dy = object.localToGlobal(Offset.zero).dy;
    if (dy < screenHeight + 50) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _started = true;
    _detachScrollListener();
    _bounceController.forward();
    _digitController.forward();
    setState(() {});
  }

  void _detachScrollListener() {
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = null;
  }

  @override
  void dispose() {
    _detachScrollListener();
    _digitController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final style = widget.style ?? defaultStyle;
    final hasDigits = _digitCount > 0;

    final tp = TextPainter(
      text: TextSpan(text: '0', style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    final digitHeight = tp.height;
    final digitWidth = tp.width;

    final children = <Widget>[];

    for (final char in _chars) {
      switch (char) {
        case _CharKindDigit(:final target, :final index):
          children.add(
            _DigitColumn(
              target: target,
              style: style,
              height: digitHeight,
              width: digitWidth,
              animation: _digitAnims[index],
            ),
          );
        case _CharKindText(:final char):
          children.add(Text(char, style: style));
      }
    }

    Widget row = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: children,
    );

    if (hasDigits) {
      row = AnimatedBuilder(
        animation: _bounceAnim,
        builder: (context, child) {
          final v = _bounceAnim.value.clamp(0.0, 1.0);
          final scale = 0.85 + v * 0.15;
          return Opacity(
            opacity: v,
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: row,
      );
    }

    return row;
  }
}

/// A single digit column that slides from 0 to its target.
class _DigitColumn extends StatelessWidget {
  const _DigitColumn({
    required this.target,
    required this.style,
    required this.height,
    required this.width,
    required this.animation,
  });

  final int target;
  final TextStyle style;
  final double height;
  final double width;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    if (target == 0) {
      return SizedBox(
        width: width,
        height: height,
        child: Text('0', style: style, textAlign: TextAlign.center),
      );
    }

    final content = OverflowBox(
      alignment: Alignment.topCenter,
      minWidth: width,
      maxWidth: width,
      minHeight: (target + 1) * height,
      maxHeight: (target + 1) * height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(target + 1, (i) {
          return SizedBox(
            height: height,
            child: Text('$i', style: style, textAlign: TextAlign.center),
          );
        }),
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -animation.value * target * height),
              child: child,
            );
          },
          child: content,
        ),
      ),
    );
  }
}

sealed class _CharKind {}

final class _CharKindDigit extends _CharKind {
  final int target;
  final int index;
  _CharKindDigit(this.target, this.index);
}

final class _CharKindText extends _CharKind {
  final String char;
  _CharKindText(this.char);
}
