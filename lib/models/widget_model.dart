class DashboardWidget {
  final String id;
  final String title;
  final String type;

  DashboardWidget({required this.id, required this.title, required this.type});

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'type': type};

  static DashboardWidget fromJson(Map<String, dynamic> json) =>
      DashboardWidget(id: json['id'], title: json['title'], type: json['type']);
}
