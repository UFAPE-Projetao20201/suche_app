import 'package:suche_app/model/ratings.dart';

/// ratings : [{"description":"","_id":"60e3834f1492dd09e6aaa9c3","user":{"isPromoter":false,"confirmedEvents":["60d7b0564a5c03141b5d4af3"],"_id":"60e380611492dd09e6aaa9c0","email":"lf@api.com","name":"Diego","surname":"dos Santos","phone":"8753116716","gender":"masculino","birthDate":"1999-06-28T18:45:15.000Z","createdAt":"2021-07-05T21:57:53.208Z","__v":1},"security":3,"quality":1,"faithfulness":2,"__v":0},{"description":"Uma descricao qualquer","_id":"60e384cc1492dd09e6aaa9cb","user":{"isPromoter":true,"confirmedEvents":["60d7b0564a5c03141b5d4af3","60e200a96a9f2000f215e413","60e48f8bef35d014595532a9","60d47f28d3482301515c8075"],"_id":"60e3841d1492dd09e6aaa9c8","email":"outro@rating.com","name":"Diego","surname":"dos Santos","phone":"8753116766","gender":"masculino","birthDate":"1999-06-28T18:45:15.000Z","createdAt":"2021-07-05T22:13:49.474Z","__v":4,"CPF_CNPJ":"13262865640646"},"security":1,"quality":5,"faithfulness":3,"__v":0}]
/// mSecurity : 2
/// mQuality : 3
/// mFaithfulness : 2.5

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
    _mFaithfulness = json["mFaithfulness"];
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
