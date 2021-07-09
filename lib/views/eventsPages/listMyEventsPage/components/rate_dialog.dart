import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:suche_app/model/rate.dart';
import 'package:suche_app/provider/rate_provider.dart';

class RateDialog extends StatefulWidget {
  final String idEvento;

  const RateDialog({
    Key? key,
    required this.idEvento,
  }) : super(key: key);

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  final double padding = 20;
  final double avatarRadius = 45;
  bool loading = false;

  double valueFaithfulness = 0;
  double valueQuality = 0;
  double valueSecurity = 0;

  @override
  void initState() {
    // loadRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Dialog(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),*/
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
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
              return SingleChildScrollView(
                // padding: mediaQuery.viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(child: Text('Insira a sua avaliação para este evento:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.black), textAlign: TextAlign.center,),),
                    const SizedBox(
                      height: 24,
                    ),
                    Text('Qual sua nota para a fidelidade do evento?',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                    RatingStars(
                      value: valueFaithfulness,
                      onValueChanged: (v) {
                        setState(() {
                          valueFaithfulness = v;
                        });
                      },
                      starSize: 30,
                      maxValueVisibility: false,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Qual sua nota para a qualidade do evento?',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                    RatingStars(
                      value: valueQuality,
                      onValueChanged: (v) {
                        setState(() {
                          valueQuality = v;
                        });
                      },
                      starSize: 30,
                      maxValueVisibility: false,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Qual sua nota para a segurança do evento?',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                    RatingStars(
                      value: valueSecurity,
                      onValueChanged: (v) {
                        setState(() {
                          valueSecurity = v;
                        });
                      },
                      starSize: 30,
                      maxValueVisibility: false,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Adicione um comentário (opcional)',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Enviar avaliação'),
                      ),
                    ),
                    /*const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Fechar'),
                      ),
                    ),*/
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}