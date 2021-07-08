import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:suche_app/model/rate.dart';
import 'package:suche_app/provider/rate_provider.dart';

class SeeRatingDialog extends StatefulWidget {
/*final Rate rate;*/
  final String idEvento;

  const SeeRatingDialog({
    Key? key,
    /*required this.rate*/
    required this.idEvento,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<SeeRatingDialog> {
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
    setState(() {
      loading = true;
    });
    final RateProvider _apiClient = RateProvider();
    var response = await _apiClient.getRatingEvent(widget.idEvento);
    setState(() {
      rate = Rate.fromJson(response);
      loading = false;
    });

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
            future: loadRating(),
            builder: (context, snapshot){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Média de ${rate.ratings!.length.toString()} avaliações',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.black),),
                  const SizedBox(
                    height: 32,
                  ),
                  Text('Nota média para fidelidade:',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mFaithfulness!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Nota média para qualidade:',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mQuality!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Nota média para segurança:',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                  RatingStars(
                    value: rate.mSecurity!,
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