import 'package:flutter/material.dart';
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
  Rate? rate = null;

  @override
  void initState() {
    loadRating();
    super.initState();
  }

  loadRating() async {
    final RateProvider _apiClient = RateProvider();
    var response = await _apiClient.getRatingEvent(widget.idEvento);
    setState(() {
      rate = Rate.fromJson(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(rate);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
          left: padding,
          top: avatarRadius + padding,
          right: padding,
          bottom: padding,
        ),
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
          visible: rate != null,
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[CircularProgressIndicator()],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Média de ${rate!.ratings!.length.toString()} avaliações',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600, color: Colors.black),),
              SizedBox(height: 15,),
              Text(rate!.mFaithfulness.toString(),style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
              Text(rate!.mQuality.toString(),style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
              Text(rate!.mSecurity.toString(),style: TextStyle(fontSize: 14, color: Colors.black),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('Fechar',style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}