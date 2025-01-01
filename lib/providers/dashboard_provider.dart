import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/widget_model.dart';
import 'package:hive/hive.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, List<DashboardWidget>>((ref) {
  return DashboardNotifier();
});

class DashboardNotifier extends StateNotifier<List<DashboardWidget>> {
  DashboardNotifier() : super([]) {
    _loadWidgets();
  }

  void addWidget(DashboardWidget widget) {
    state = [...state, widget];
    _saveWidgets();
  }

  void removeWidget(String id) {
    state = state.where((widget) => widget.id != id).toList();
    _saveWidgets();
  }

  void reorderWidgets(int oldIndex, int newIndex) {
    final widgets = [...state];
    final widget = widgets.removeAt(oldIndex);
    widgets.insert(newIndex, widget);
    state = widgets;
    _saveWidgets();
  }

  void _saveWidgets() {
    final box = Hive.box('dashboard');
    box.put('widgets', state.map((w) => w.toJson()).toList());
  }

  void _loadWidgets() {
    final box = Hive.box('dashboard');
    final savedWidgets = box.get('widgets', defaultValue: []) as List;

    // Ensure proper type casting
    state = savedWidgets.map((w) {
      final widgetMap = Map<String, dynamic>.from(w as Map);
      return DashboardWidget.fromJson(widgetMap);
    }).toList();
  }

}
