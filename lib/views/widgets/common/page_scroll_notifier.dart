import 'package:flutter/widgets.dart';

/// Shares a single [ValueNotifier<double>] (the page scroll offset) with all
/// descendants so [RevealOnScroll] and [AnimatedCounter] can subscribe to it
/// rather than each attaching their own [ScrollPosition] listener.
///
/// The [AppShell] drives the notifier via a [NotificationListener]; widgets
/// downstream just call [PageScrollNotifier.of] to get the notifier and add
/// one lightweight callback — no element-tree traversal per scroll frame.
class PageScrollNotifier extends InheritedWidget {
  const PageScrollNotifier({
    super.key,
    required this.notifier,
    required super.child,
  });

  final ValueNotifier<double> notifier;

  /// Returns the nearest [ValueNotifier<double>] without establishing a
  /// rebuild dependency (we subscribe manually in [initState]).
  static ValueNotifier<double>? of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<PageScrollNotifier>()?.notifier;

  @override
  bool updateShouldNotify(PageScrollNotifier old) => notifier != old.notifier;
}
