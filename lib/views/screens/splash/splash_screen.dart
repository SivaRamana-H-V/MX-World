import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mxworld/core/routing/app_router.dart';
import 'package:mxworld/core/theme/app_colors.dart';

/// A minimal, premium splash screen shown on cold start.
///
/// A single [AnimationController] drives three sequenced phases on the brand
/// mark: an entrance (fade-in + scale-up), a hold, and an exit (fade-out).
/// When the exit completes the screen routes to the home page. Driving every
/// phase from one controller keeps the work on a single ticker, which is ideal
/// for steady 60 FPS on CanvasKit web builds.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  /// Total time the splash is visible before navigation begins.
  static const Duration totalDuration = Duration(milliseconds: 2500);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Logo entrance: fades in over the first 28% of the timeline.
  late final Animation<double> _logoFade;
  // Logo entrance: scales from 0.82 -> 1.0 with an overshoot-free ease.
  late final Animation<double> _logoScale;
  // Accent underline reveal that draws in after the logo settles.
  late final Animation<double> _underline;
  // Whole-screen fade-out across the final 18% of the timeline.
  late final Animation<double> _screenFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SplashScreen.totalDuration,
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.28, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.40, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _underline = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.55, curve: Curves.easeInOutCubic),
    );

    _screenFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.82, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.addStatusListener(_onStatusChanged);
    _controller.forward();
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      splashComplete = true;
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_onStatusChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _screenFade.value,
            child: Center(
              child: Opacity(
                opacity: _logoFade.value,
                child: Transform.scale(
                  scale: _logoScale.value,
                  child: child,
                ),
              ),
            ),
          );
        },
        // The brand mark is built once and reused every frame via `child`,
        // so only the cheap opacity/scale wrappers rebuild per tick.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/logo_stacked_dark.png',
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 14),
            _AnimatedUnderline(progress: _underline),
            const SizedBox(height: 18),
            Text(
              'GLOBAL LOGISTICS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textOnDarkTertiary,
                    letterSpacing: 4.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A thin accent rule that grows from the center outward as [progress] runs.
class _AnimatedUnderline extends StatelessWidget {
  const _AnimatedUnderline({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (BuildContext context, _) {
        return Container(
          width: 200 * progress.value,
          height: 2,
          color: AppColors.accent,
        );
      },
    );
  }
}
