import 'package:dynamic_dashboard_widget/widgets/news_feed_widget.dart';
import 'package:flutter/material.dart';
import 'weather_widget.dart';

class WidgetFactory extends StatelessWidget {
  final String type;

  WidgetFactory({required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'weather':
      case 'stocks':
        return WeatherWidget();
      case 'news_feed':
        return NewsFeedWidget();
      default:
        return const Placeholder();
    }
  }
}
