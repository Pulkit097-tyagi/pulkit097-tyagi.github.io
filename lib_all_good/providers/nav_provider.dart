import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavState {
  final int activeIndex;
  final List<GlobalKey> keys;

  NavState({
    required this.activeIndex,
    required this.keys,
  });

  NavState copyWith({
    int? activeIndex,
    List<GlobalKey>? keys,
  }) {
    return NavState(
      activeIndex: activeIndex ?? this.activeIndex,
      keys: keys ?? this.keys,
    );
  }
}

class NavNotifier extends Notifier<NavState> {
  @override
  NavState build() {
    return NavState(
      activeIndex: 0,
      keys: List.generate(6, (index) => GlobalKey(debugLabel: 'section_$index')),
    );
  }

  final List<String> sectionNames = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact'
  ];

  void setActiveIndex(int index) {
    if (state.activeIndex != index) {
      state = state.copyWith(activeIndex: index);
    }
  }

  void scrollToSection(int index) {
    setActiveIndex(index);
    final key = state.keys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}

final navProvider = NotifierProvider<NavNotifier, NavState>(NavNotifier.new);
