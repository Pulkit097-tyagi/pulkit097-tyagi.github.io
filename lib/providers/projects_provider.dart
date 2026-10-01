import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/project.dart';

const List<String> projectFilters = [
  'All',
  'Featured',
  'Flutter',
  'Firebase',
  'SQLite',
  'REST API',
  'Agri-Tech',
];

class ProjectFilterNotifier extends Notifier<String> {
  @override
  String build() => projectFilters.first;

  void select(String filter) => state = filter;
}

final projectFilterProvider =
    NotifierProvider<ProjectFilterNotifier, String>(ProjectFilterNotifier.new);

/// Projects matching the selected filter; recomputed only when it changes.
final filteredProjectsProvider = Provider<List<Project>>((ref) {
  final filter = ref.watch(projectFilterProvider);
  return AppConstants.projects.where((project) {
    if (filter == 'All') return true;
    if (filter == 'Featured') return project.isFeatured;
    return project.tags.any((tag) => tag.toLowerCase() == filter.toLowerCase());
  }).toList();
});
