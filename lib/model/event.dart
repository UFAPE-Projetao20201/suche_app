import 'package:suche_app/model/localization.dart';
import 'package:suche_app/model/user.dart';

class Event {
  final User promoter;
  final String name;
  final String description;
  final String category;
  final double value;
  final DateTime date;
  final List<String> keywords;
  final String link;
  final bool isOnline;
  final bool isLocal;
  final Localization localization;

  Event({
    required this.promoter,
    required this.name,
    required this.description,
    required this.category,
    required this.value,
    required this.date,
    required this.keywords,
    required this.link,
    required this.isOnline,
    required this.isLocal,
    required this.localization,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      promoter: User.fromJson(json['promoter']),
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      value: json['value'] as double,
      date: json['date'] as DateTime,
      keywords: json['keywords'] as List<String>,
      link: json['link'] as String,
      isOnline: json['isOnline'].toString() == 'true' ? true : false,
      isLocal: json['isLocal'].toString() == 'true' ? true : false,
      localization: Localization.fromJson(json['localization']),
    );
  }

  @override
  String toString() {
    return 'Event{promoter: $promoter, name: $name, description: $description, category: $category, value: $value, date: $date, keywords: $keywords, link: $link, isOnline: $isOnline, isLocal: $isLocal, localization: $localization}';
  }
}
