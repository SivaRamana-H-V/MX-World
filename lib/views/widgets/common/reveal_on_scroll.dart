import 'package:flutter/material.dart';

/// Gently reveals its [child] with a fade and a short upward drift the first
/// time the widget scrolls into the viewport.
///
/// Designed for 60 FPS on CanvasKit web:
/// * A single [AnimationController] per instance drives one [FadeTransition]
///   and one [SlideTransition] — no nested opacity layers, no `Transform.rotate`.
/// * Visibility is detected by reading the enclosing [Scrollable]'s position
///   and comparing this element's paint bounds against the viewport. The scroll
///   listener is removed the moment the reveal fires, so there is zero ongoing
///   per-frame cost once an item has appeared.
/// * Items already on-screen at first layout animate immediately; items below
///   the fold wait until they are scrolled near.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.offset = 32,
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.visibleFraction = 0.1,
  });

  /// The content to reveal.
  final Widget child;

  /// Stagger delay applied before this item begins animating. Use increasing
  /// delays across siblings to create a cascading entrance.
  final Duration delay;

  /// Length of the fade/slide animation.
  final Duration duration;

  /// Vertical distance, in logical pixels, the child drifts up from.
  final double offset;

  /// Easing curve for both the fade and the slide.
  final Curve curve;

  /// Fraction of the viewport height an item must enter before it reveals.
  final double visibleFraction;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  ScrollPosition? _position;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final CurvedAnimation eased =
        CurvedAnimation(parent: _controller, curve: widget.curve);

    _fade = eased;
    _slide = Tween<Offset>(
      // SlideTransition uses fractions of the child's own size, so derive the
      // fraction lazily once we know nothing about size here; a small constant
      // fraction reads as a subtle drift across typical component heights.
      begin: Offset(0, widget.offset / 240),
      end: Offset.zero,
    ).animate(eased);

    WidgetsBinding.instance.addPostFrameCallback((_) => _attachAndCheck());
  }

  void _attachAndCheck() {
    if (!mounted) return;
    context.visitAncestorElements((element) {
      if (element.widget is Scrollable) {
        final scrollable = element.widget as Scrollable;
        final physics = scrollable.physics;
        if (physics == null || physics is! NeverScrollableScrollPhysics) {
          final stateElement = element as StatefulElement;
          _position = (stateElement.state as ScrollableState).position;
          _position!.addListener(_onScroll);
          return false;
        }
      }
      return true;
    });
    _maybeReveal();
  }

  void _onScroll() => _maybeReveal();

  void _maybeReveal() {
    if (_revealed || !mounted) return;
    final RenderObject? object = context.findRenderObject();
    if (object is! RenderBox || !object.attached) return;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double dy = object.localToGlobal(Offset.zero).dy;
    final double threshold = screenHeight * (1 - widget.visibleFraction);

    if (dy < threshold) {
      _revealed = true;
      _detachListener();
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

  void _detachListener() {
    _position?.removeListener(_onScroll);
    _position = null;
  }

  @override
  void dispose() {
    _detachListener();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// Lays out [children] in a vertical column where each child reveals in turn
/// with an increasing [stagger] delay, producing a smooth cascade.
///
/// A thin convenience wrapper over [RevealOnScroll] for the common case of a
/// stacked group (headers, list rows, footer columns).
class RevealColumn extends StatelessWidget {
  const RevealColumn({
    super.key,
    required this.children,
    this.stagger = const Duration(milliseconds: 90),
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
          RevealOnScroll(
            delay: stagger * i,
            child: children[i],
          ),
          if (spacing > 0 && i < children.length - 1)
            SizedBox(height: spacing),
        ],
      ],
    );
  }
}
