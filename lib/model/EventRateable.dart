// Project imports:
import 'package:suche_app/model/event.dart';

class EventRateable {
  Event? _event;
  late bool _rated;

  Event? get event => _event;

  bool get rated => _rated;

  set rated(bool value) {
    _rated = value;
  }

  EventRateable({Event? event, required bool imIn}) {
    _event = event;
    _rated = imIn;
  }

  factory EventRateable.fromJson(Map<String, dynamic> json) {
    return EventRateable(
      event: json["event"] != null ? Event.fromJson(json["event"]) : null,
      imIn: json["rated"],
    );
  }

  @override
  String toString() {
    return 'EventImIn{_rated: $_rated, _event: {...}}}';
  }
}
