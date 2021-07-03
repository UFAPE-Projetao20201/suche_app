// Project imports:
import 'package:suche_app/model/localization.dart';
import 'package:suche_app/model/user.dart';

class Event {
  final String id;
  final User? promoter; //NULLABLE ??
  final String name;
  final String description;
  final String category;
  final double value;
  final DateTime date;
  final List<dynamic> keywords;
  final String link;
  final bool isOnline;
  final bool isLocal;
  final Localization? localization; //NULLABLE ??

  Event({
    required this.id,
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
      id:  json['_id'] as String,
      promoter: json['promoter'] != null ? User.fromJson(json['promoter'], fromRequisition: 'event') : null,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      value: json['value'].toDouble(),
      date: DateTime.parse(json['date']),
      keywords: json['keywords'] as List<dynamic>,
      link: json['link'] as String,
      isOnline: json['isOnline'].toString() == 'true' ? true : false,
      isLocal: json['isLocal'].toString() == 'true' ? true : false,
      localization: json['localization'] != null ? Localization.fromJson(json['localization']) : null,
    );
  }

  @override
  String toString() {
    return 'Event{id: $id, promoter: $promoter, name: $name, description: $description, category: $category, value: $value, date: $date, keywords: $keywords, link: $link, isOnline: $isOnline, isLocal: $isLocal, localization: $localization}';
  }
}
