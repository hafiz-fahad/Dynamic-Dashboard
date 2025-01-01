import 'package:dynamic_dashboard_widget/models/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/widget_factory.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Dashboard'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (type) {
              notifier.addWidget(DashboardWidget(
                id: DateTime.now().toString(),
                title: '${type[0].toUpperCase()}${type.substring(1)} Widget',
                type: type,
              ));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'weather', child: Text('Weather')),
              const PopupMenuItem(value: 'stocks', child: Text('Stocks')),
              const PopupMenuItem(value: 'news_feed', child: Text('News Feed')),
            ],
          ),
        ],
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          notifier.reorderWidgets(oldIndex, newIndex);
        },
        children: widgets.map((widget) {
          return Card(
            key: ValueKey(widget.id),
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => notifier.removeWidget(widget.id),
                  ),
                ),
                WidgetFactory(type: widget.type), // Use WidgetFactory here
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
