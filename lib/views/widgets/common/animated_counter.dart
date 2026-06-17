import 'package:flutter/material.dart';

import 'page_scroll_notifier.dart';

/// Animated counter that reveals each digit with a rolling odometer effect.
///
/// Performance fixes vs. original:
/// * [TextPainter] metrics are computed once in [didChangeDependencies] and
///   cached — the original called [TextPainter.layout] on every [build], which
///   forced a synchronous text-layout pass every frame.
/// * Subscribes to [PageScrollNotifier] instead of attaching its own
///   [ScrollPosition] listener, keeping the per-scroll work to O(1).
/// * [TextPainter] is properly disposed to avoid memory leaks.
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

  // Cached text metrics — recomputed only in didChangeDependencies.
  double _digitHeight = 0;
  double _digitWidth = 0;
  TextStyle? _resolvedStyle;

  bool _started = false;
  ValueNotifier<double>? _notifier;

  @override
  void initState() {
    super.initState();
    _parseValue();
    _digitController =
        AnimationController(vsync: this, duration: _totalDuration);
    _bounceController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600),);
    _bounceAnim =
        CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut);
    _initDigitAnims();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Subscribe to the page-level scroll notifier.
    final ValueNotifier<double>? next = PageScrollNotifier.of(context);
    if (next != _notifier) {
      _notifier?.removeListener(_onScroll);
      _notifier = next;
      if (!_started) _notifier?.addListener(_onScroll);
    }

    // Compute and cache text metrics — TextPainter.layout() is expensive;
    // doing it here instead of build() avoids it running every frame.
    final TextStyle style =
        widget.style ?? DefaultTextStyle.of(context).style;
    if (style != _resolvedStyle) {
      _resolvedStyle = style;
      final TextPainter tp = TextPainter(
        text: TextSpan(text: '0', style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      _digitHeight = tp.height;
      _digitWidth = tp.width;
      tp.dispose();
    }

    // First-frame check for widgets already in the viewport.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _maybeStart());
  }

  Duration get _totalDuration {
    if (_digitCount <= 1) return widget.duration;
    return widget.duration + widget.staggerDelay * (_digitCount - 1);
  }

  void _parseValue() {
    _chars.clear();
    _digitCount = 0;
    for (int i = 0; i < widget.value.length; i++) {
      final String c = widget.value[i];
      final int code = c.codeUnitAt(0);
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
    final int totalMs = _totalDuration.inMilliseconds;
    for (int i = 0; i < _digitCount; i++) {
      final int startMs = widget.staggerDelay.inMilliseconds * i;
      final int endMs = startMs + widget.duration.inMilliseconds;
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

  void _onScroll() => _maybeStart();

  void _maybeStart() {
    if (_started || !mounted) return;
    final RenderObject? obj = context.findRenderObject();
    if (obj is! RenderBox || !obj.attached) return;
    final double screenH = MediaQuery.sizeOf(context).height;
    final double dy = obj.localToGlobal(Offset.zero).dy;
    if (dy < screenH + 50) {
      _started = true;
      _notifier?.removeListener(_onScroll);
      _notifier = null;
      _bounceController.forward();
      _digitController.forward();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _notifier?.removeListener(_onScroll);
    _digitController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = _resolvedStyle ??
        widget.style ??
        DefaultTextStyle.of(context).style;
    final bool hasDigits = _digitCount > 0;

    final List<Widget> children = <Widget>[];
    for (final _CharKind char in _chars) {
      switch (char) {
        case _CharKindDigit(:final target, :final index):
          children.add(_DigitColumn(
            target: target,
            style: style,
            height: _digitHeight,
            width: _digitWidth,
            animation: _digitAnims[index],
          ),);
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
        builder: (BuildContext context, Widget? child) {
          final double v = _bounceAnim.value.clamp(0.0, 1.0);
          return Opacity(
            opacity: v,
            child: Transform.scale(scale: 0.85 + v * 0.15, child: child),
          );
        },
        child: row,
      );
    }

    return row;
  }
}

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

    final Widget content = OverflowBox(
      alignment: Alignment.topCenter,
      minWidth: width,
      maxWidth: width,
      minHeight: (target + 1) * height,
      maxHeight: (target + 1) * height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          target + 1,
          (int i) => SizedBox(
            height: height,
            child: Text('$i', style: style, textAlign: TextAlign.center),
          ),
        ),
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) => Transform.translate(
            offset: Offset(0, -animation.value * target * height),
            child: child,
          ),
          child: content,
        ),
      ),
    );
  }
}

sealed class _CharKind {}

final class _CharKindDigit extends _CharKind {
  _CharKindDigit(this.target, this.index);
  final int target;
  final int index;
}

final class _CharKindText extends _CharKind {
  _CharKindText(this.char);
  final String char;
}
