import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Every scrollable section of the page, in display order.
enum AppSection {
  home('Home'),
  about('About'),
  skills('Skills'),
  projects('Projects'),
  experience('Experience'),
  contact('Contact');

  final String label;
  const AppSection(this.label);
}

/// Height of the floating navbar; content scrolls underneath it.
const double kNavbarHeight = 70.0;

/// Single scroll controller for the main page, disposed with the provider.
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

/// One stable key per section, used to measure and scroll to it.
final sectionKeysProvider = Provider<Map<AppSection, GlobalKey>>((ref) {
  return {
    for (final section in AppSection.values)
      section: GlobalKey(debugLabel: 'section_${section.name}'),
  };
});

@immutable
class NavState {
  final AppSection active;
  final bool isScrolled;
  final bool showBackToTop;

  const NavState({
    this.active = AppSection.home,
    this.isScrolled = false,
    this.showBackToTop = false,
  });

  NavState copyWith({
    AppSection? active,
    bool? isScrolled,
    bool? showBackToTop,
  }) {
    return NavState(
      active: active ?? this.active,
      isScrolled: isScrolled ?? this.isScrolled,
      showBackToTop: showBackToTop ?? this.showBackToTop,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is NavState &&
      other.active == active &&
      other.isScrolled == isScrolled &&
      other.showBackToTop == showBackToTop;

  @override
  int get hashCode => Object.hash(active, isScrolled, showBackToTop);
}

/// Derives navigation state from the scroll position and drives
/// programmatic scrolling to sections.
class NavNotifier extends Notifier<NavState> {
  /// While a nav-triggered animation runs, sections passed on the way
  /// must not steal the active highlight.
  bool _isAutoScrolling = false;

  ScrollController get _controller => ref.read(scrollControllerProvider);

  @override
  NavState build() {
    final controller = ref.watch(scrollControllerProvider);
    controller.addListener(_onScroll);
    ref.onDispose(() => controller.removeListener(_onScroll));
    return const NavState();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;

    final next = state.copyWith(
      active: _isAutoScrolling ? state.active : _resolveActive(position),
      isScrolled: position.pixels > 8,
      showBackToTop: position.pixels > position.viewportDimension * 0.8,
    );
    if (next != state) state = next;
  }

  /// The active section is the last one whose top edge has crossed a
  /// probe line ~35% down the viewport. This works for sections of any
  /// height, unlike a visible-fraction threshold.
  AppSection _resolveActive(ScrollPosition position) {
    if (position.pixels >= position.maxScrollExtent - 4) {
      return AppSection.values.last;
    }

    final probe = position.viewportDimension * 0.35;
    final keys = ref.read(sectionKeysProvider);
    var active = AppSection.home;

    for (final section in AppSection.values) {
      final box = keys[section]?.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= probe) active = section;
    }
    return active;
  }

  Future<void> scrollTo(AppSection section) async {
    final box = ref.read(sectionKeysProvider)[section]?.currentContext?.findRenderObject();
    if (box is! RenderBox || !_controller.hasClients) return;

    final position = _controller.position;
    final target = (position.pixels + box.localToGlobal(Offset.zero).dy - kNavbarHeight)
        .clamp(position.minScrollExtent, position.maxScrollExtent);

    _isAutoScrolling = true;
    state = state.copyWith(active: section);
    try {
      await _controller.animateTo(
        target,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    } finally {
      _isAutoScrolling = false;
    }
  }
}

final navProvider = NotifierProvider<NavNotifier, NavState>(NavNotifier.new);
