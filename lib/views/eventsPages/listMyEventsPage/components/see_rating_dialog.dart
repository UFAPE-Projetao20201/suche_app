// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

// Project imports:
import 'package:suche_app/model/rate.dart';
import 'package:suche_app/provider/rate_provider.dart';

class SeeRatingDialog extends StatefulWidget {
  final String idEvento;

  const SeeRatingDialog({
    Key? key,
    required this.idEvento,
  }) : super(key: key);

  @override
  _SeeRatingDialogState createState() => _SeeRatingDialogState();
}

class _SeeRatingDialogState extends State<SeeRatingDialog> {
  final double padding = 20;
  final double avatarRadius = 45;
  Rate rate = Rate();
  bool loading = false;

  @override
  void initState() {
    loadRating();
    super.initState();
  }

  Future loadRating() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    final RateProvider _apiClient = RateProvider();
    var response = await _apiClient.getRatingEvent(widget.idEvento);

    if (mounted) {
      setState(() {
        rate = Rate.fromJson(response);
        loading = false;
      });
    }

    return rate;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(padding, padding + 12, padding, padding),
        margin: EdgeInsets.only(top: avatarRadius, bottom: avatarRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 10), blurRadius: 10),
            ],),
        child: Visibility(
          visible: !loading,
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          child: FutureBuilder(
            builder: (context, snapshot){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Média de ${rate.ratings!.length.toString()} avaliações',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.black),),
                  const SizedBox(
                    height: 32,
                  ),
                  Text('Nota média para fidelidade:',style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mFaithfulness!,
                    starSize: 30,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Nota média para qualidade:',style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mQuality!,
                    starSize: 30,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Nota média para segurança:',style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mSecurity!,
                    starSize: 30,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
