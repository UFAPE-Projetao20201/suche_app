// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

// Project imports:
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/rate_provider.dart';
import 'package:suche_app/util/constants.dart';

class RateDialog extends StatefulWidget {
  final String idEvento;
  final User user;

  const RateDialog({
    Key? key,
    required this.idEvento,
    required this.user,
  }) : super(key: key);

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  TextEditingController _descriptionController = TextEditingController();

  final double padding = 20;
  final double avatarRadius = 45;

  bool loading = false;
  bool rated = false;

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
    return WillPopScope(
      onWillPop: () async => rated ? false : true,
      child: Dialog(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Visibility(
                        visible: !rated,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('X'),
                          ),
                        ),
                      ),
                      Align(child: Text('Insira a sua avaliação para este evento:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.black), textAlign: TextAlign.center,),),
                      const SizedBox(
                        height: 24,
                      ),
                      Text('Qual sua nota para a fidelidade do evento?',style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
                      RatingStars(
                        value: valueFaithfulness,
                        onValueChanged: !rated ? (v) {
                          setState(() {
                            valueFaithfulness = v;
                          });
                        } : null,
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
                        onValueChanged: !rated ? (v) {
                          setState(() {
                            valueQuality = v;
                          });
                        } : null,
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
                        onValueChanged: !rated ? (v) {
                          setState(() {
                            valueSecurity = v;
                          });
                        } : null,
                        starSize: 30,
                        maxValueVisibility: false,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: !rated ? 'Adicione um comentário (opcional)' : _descriptionController.text,
                          isDense: true,
                        ),
                        enabled: !rated,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            if(!rated) {
                              setState(() {
                                loading = true;
                              });

                              final RateProvider _apiClient = RateProvider();

                              await _apiClient.sendRateEvent(widget.idEvento, widget.user.id, widget.user.token, valueFaithfulness, valueQuality, valueSecurity, _descriptionController.text).whenComplete(() => setState((){rated = true;}));

                              setState(() {
                                loading = false;
                              });
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context, homeRoute, (Route<dynamic> route) => false, arguments: widget.user);
                            }
                          },
                          child: Text(rated ? 'Voltar para home' : 'Enviar avaliação'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
