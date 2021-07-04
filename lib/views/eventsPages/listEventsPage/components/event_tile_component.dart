// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/model/event_im_in.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/event_provider.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';

class EventTileComponent extends StatefulWidget {
  final EventImIn eventImIn;
  final User user;

  const EventTileComponent(
      {Key? key, required this.eventImIn, required this.user})
      : super(key: key);

  @override
  _EventTileComponentState createState() => _EventTileComponentState();
}

class _EventTileComponentState extends State<EventTileComponent> {
  bool loading = false;
  bool _absorbing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      padding: EdgeInsets.all(15.0),
      color: CustomColors.colorLightGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Nome do Evento
          Text(
            widget.eventImIn.event!.name,
            style: TextStyle(
              color: CustomColors.orangePrimary.shade400,
              fontFamily: 'OpenSans',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),

          // Descrição do evento
          Text(
            widget.eventImIn.event!.description,
            style: TextStyle(
                color: CustomColors.colorOrangeSecondary,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 5.0),

          //Promotor do evento
          Row(children: <Widget>[
            Icon(
              Mdi.accountOutline,
              color: CustomColors.colorOrangeSecondary,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              widget.eventImIn.event!.promoter == null
                  ? 'Não informado'
                  : widget.eventImIn.event!.promoter!.name +
                      ' ' +
                      widget.eventImIn.event!.promoter!.surname, // NULLABLE ??
              style: TextStyle(
                color: CustomColors.colorOrangeSecondary,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),

          //Data do evento
          Row(
            children: <Widget>[
              Icon(
                Mdi.calendarStar,
                color: CustomColors.colorOrangeSecondary,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                DateFormat('dd/MM/yyyy – HH:mm')
                    .format(widget.eventImIn.event!.date),
                style: TextStyle(
                  color: CustomColors.colorOrangeSecondary,
                  fontFamily: 'OpenSans',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          //Valor do evento
          Row(children: <Widget>[
            Icon(
              Mdi.cash,
              color: CustomColors.colorOrangeSecondary,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              Util.toMoney(widget.eventImIn.event!.value),
              style: TextStyle(
                color: CustomColors.colorOrangeSecondary,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ]),

          //Local do evento (online/presencial)
          Visibility(
            visible: widget.eventImIn.event!.localization != null,
            child: Row(children: <Widget>[
              Icon(
                Mdi.mapMarker,
                color: CustomColors.colorOrangeSecondary,
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  widget.eventImIn.event!.localization == null
                      ? 'Não informado'
                      : widget.eventImIn.event!.localization!.street +
                          ', Nº ' +
                          widget.eventImIn.event!.localization!.number
                              .toString() +
                          ' - ' +
                          widget.eventImIn.event!.localization!
                              .city, // NULLABLE ??
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
            replacement: Row(children: <Widget>[
              Icon(
                Mdi.link,
                color: CustomColors.colorOrangeSecondary,
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  widget.eventImIn.event!.link, // NULLABLE ??
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          ),

          //Categoria do evento
          Row(children: <Widget>[
            Icon(
              Mdi.formatListChecks,
              color: CustomColors.colorOrangeSecondary,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              widget.eventImIn.event!.category,
              style: TextStyle(
                color: CustomColors.colorOrangeSecondary,
                fontFamily: 'OpenSans',
                fontSize: 15.0,
              ),
            ),
          ]),

          const SizedBox(
            height: 16,
          ),

          Center(
            child: Container(
              // color: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 84),
              child: AbsorbPointer(
                absorbing: _absorbing,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !_absorbing,
                        replacement: Container(child: CircularProgressIndicator(strokeWidth: 2,), width: 22, height: 22, margin: EdgeInsets.all(13),),
                        child: Checkbox(
                          value: widget.eventImIn.imIn,
                          onChanged: (value) async {
                            if (!value!) {
                              setState(() {
                                loading = true;
                                _absorbing = true;
                              });

                              final EventProvider _apiClient = EventProvider();

                              await _apiClient.unconfirmPresence(
                                  widget.eventImIn.event!.id,
                                  widget.user.email,
                                  widget.user.token);

                              widget.eventImIn.imIn = !widget.eventImIn.imIn;

                              setState(() {
                                loading = false;
                                _absorbing = false;
                              });
                            } else {
                              setState(() {
                                loading = true;
                                _absorbing = true;
                              });

                              final EventProvider _apiClient = EventProvider();

                              await _apiClient.confirmPresence(
                                  widget.eventImIn.event!.id,
                                  widget.user.email,
                                  widget.user.token);

                              widget.eventImIn.imIn = !widget.eventImIn.imIn;

                              setState(() {
                                loading = false;
                                _absorbing = false;
                              });
                            }

                            /*setState(() {
                            print('antes: ' + widget.eventImIn.toString());
                            widget.eventImIn.imIn = !widget.eventImIn.imIn;
                            print('dps: ' + widget.eventImIn.toString());
                          });*/
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Tô dentro  ',
                          style: TextStyle(
                              color: CustomColors.colorOrangeSecondary,
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
