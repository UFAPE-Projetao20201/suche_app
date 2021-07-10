// Project imports:
import 'package:suche_app/model/user.dart';

class Ratings {
  String? _description;
  String? _id;
  User? _user;
  int? _security;
  int? _quality;
  int? _faithfulness;
  int? _v;

  String? get description => _description;
  String? get id => _id;
  User? get user => _user;
  int? get security => _security;
  int? get quality => _quality;
  int? get faithfulness => _faithfulness;
  int? get v => _v;

  Ratings({
    String? description,
    String? id,
    User? user,
    int? security,
    int? quality,
    int? faithfulness,
    int? v}){
    _description = description;
    _id = id;
    _user = user;
    _security = security;
    _quality = quality;
    _faithfulness = faithfulness;
    _v = v;
  }

  Ratings.fromJson(dynamic json) {
    _description = json["description"];
    _id = json["_id"];
    _user = json["user"] != null ? User.fromJson(json["user"], fromRequisition: 'event') : null;
    _security = json["security"];
    _quality = json["quality"];
    _faithfulness = json["faithfulness"];
    _v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = _description;
    map["_id"] = _id;
    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    map["security"] = _security;
    map["quality"] = _quality;
    map["faithfulness"] = _faithfulness;
    map["__v"] = _v;
    return map;
  }

}
