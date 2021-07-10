// Project imports:
import 'package:suche_app/model/ratings.dart';

class Rate {
  List<Ratings>? _ratings;
  double? _mSecurity;
  double? _mQuality;
  double? _mFaithfulness;

  List<Ratings>? get ratings => _ratings;

  double? get mSecurity => _mSecurity;

  double? get mQuality => _mQuality;

  double? get mFaithfulness => _mFaithfulness;

  Rate(
      {List<Ratings>? ratings,
      double? mSecurity,
      double? mQuality,
      double? mFaithfulness}) {
    _ratings = ratings;
    _mSecurity = mSecurity;
    _mQuality = mQuality;
    _mFaithfulness = mFaithfulness;
  }

  Rate.fromJson(dynamic json) {
    if (json["ratings"] != null) {
      _ratings = [];
      json["ratings"].forEach((v) {
        _ratings?.add(Ratings.fromJson(v));
      });
    }
    _mSecurity = json["mSecurity"].toDouble();
    _mQuality = json["mQuality"].toDouble();
    _mFaithfulness = json["mFaithfulness"].toDouble();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_ratings != null) {
      map["ratings"] = _ratings?.map((v) => v.toJson()).toList();
    }
    map["mSecurity"] = _mSecurity;
    map["mQuality"] = _mQuality;
    map["mFaithfulness"] = _mFaithfulness;
    return map;
  }

  @override
  String toString() {
    return 'Rate{_ratings size: ${_ratings!.length}, _mSecurity: $_mSecurity, _mQuality: $_mQuality, _mFaithfulness: $_mFaithfulness}';
  }
}
