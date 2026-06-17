import 'package:flutter/material.dart';

import 'page_scroll_notifier.dart';

/// Gently reveals its [child] with a fade and a short upward drift the first
/// time the widget scrolls into the viewport.
///
/// Performance notes:
/// * Subscribes to the app-level [PageScrollNotifier] instead of attaching its
///   own [ScrollPosition] listener, so there is only ONE scroll notification
///   source for the entire page regardless of how many [RevealOnScroll]
///   instances exist.
/// * A [RepaintBoundary] isolates each animated section so neighbouring
///   sections are not repainted while this one's entrance animation runs.
/// * After the reveal fires, the listener is removed — zero ongoing cost.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 450),
    this.offset = 28.0,
    this.curve = Curves.fastOutSlowIn,
    this.visibleFraction = 0.05,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;
  final Curve curve;
  final double visibleFraction;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  ValueNotifier<double>? _notifier;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final CurvedAnimation eased =
        CurvedAnimation(parent: _controller, curve: widget.curve);
    _fade = eased;
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 240),
      end: Offset.zero,
    ).animate(eased);

    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeReveal());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ValueNotifier<double>? next = PageScrollNotifier.of(context);
    if (next != _notifier) {
      _notifier?.removeListener(_onScroll);
      _notifier = next;
      if (!_revealed) _notifier?.addListener(_onScroll);
    }
  }

  void _onScroll() => _maybeReveal();

  void _maybeReveal() {
    if (_revealed || !mounted) return;
    final RenderObject? obj = context.findRenderObject();
    if (obj is! RenderBox || !obj.attached) return;

    final double screenH = MediaQuery.sizeOf(context).height;
    final double dy = obj.localToGlobal(Offset.zero).dy;
    if (dy < screenH * (1 - widget.visibleFraction)) {
      _revealed = true;
      _notifier?.removeListener(_onScroll);
      _notifier = null;
      _play();
    }
  }

  void _play() {
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _notifier?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}

/// Stacks [children] where each reveals in turn with an increasing [stagger].
class RevealColumn extends StatelessWidget {
  const RevealColumn({
    super.key,
    required this.children,
    this.stagger = const Duration(milliseconds: 80),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.spacing = 0,
  });

  final List<Widget> children;
  final Duration stagger;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < children.length; i++) ...<Widget>[
          RevealOnScroll(delay: stagger * i, child: children[i]),
          if (spacing > 0 && i < children.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }
}
