// Project imports:
import 'package:suche_app/model/event.dart';

class EventImIn {
  Event? _event;
  late bool _imIn;

  Event? get event => _event;
  bool get imIn => _imIn;


  set imIn(bool value) {
    _imIn = value;
  }

  EventImIn({
    Event? event,
    required bool imIn}) {
    _event = event;
    _imIn = imIn;
  }

  factory EventImIn.fromJson(Map<String, dynamic> json) {
    return EventImIn(
      event: json["event"] != null ? Event.fromJson(json["event"]) : null,
      imIn: json["imIn"],
    );
  }

  @override
  String toString() {
    return 'EventImIn{_imIn: $_imIn, _event: {...}}}';
  }
}
