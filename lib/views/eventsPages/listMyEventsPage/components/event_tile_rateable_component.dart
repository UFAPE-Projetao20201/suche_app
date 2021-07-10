// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/model/event_rateable.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/eventsPages/listMyEventsPage/components/rate_dialog.dart';
import 'package:suche_app/views/eventsPages/listMyEventsPage/components/see_rating_dialog.dart';

class EventTileRateableComponent extends StatefulWidget {
  final EventRateable eventRateable;
  final User user;

  const EventTileRateableComponent(
      {Key? key, required this.eventRateable, required this.user})
      : super(key: key);

  @override
  _EventTileRateableComponentState createState() => _EventTileRateableComponentState();
}

class _EventTileRateableComponentState extends State<EventTileRateableComponent> {
  bool loading = false;

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
            widget.eventRateable.event!.name,
            style: TextStyle(
              color: CustomColors.orangePrimary.shade400,
              fontFamily: 'OpenSans',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),

          // Descrição do evento
          Text(
            widget.eventRateable.event!.description,
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
              widget.eventRateable.event!.promoter == null
                  ? 'Não informado'
                  : widget.eventRateable.event!.promoter!.name +
                      ' ' +
                      widget.eventRateable.event!.promoter!.surname, // NULLABLE ??
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
                    .format(widget.eventRateable.event!.date),
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
              Util.toMoney(widget.eventRateable.event!.value),
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
            visible: widget.eventRateable.event!.localization != null,
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
                  widget.eventRateable.event!.localization == null
                      ? 'Não informado'
                      : widget.eventRateable.event!.localization!.street +
                          ', Nº ' +
                          widget.eventRateable.event!.localization!.number
                              .toString() +
                          ' - ' +
                          widget.eventRateable.event!.localization!
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
                  widget.eventRateable.event!.link, // NULLABLE ??
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
              widget.eventRateable.event!.category,
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

          Visibility(
            visible: !widget.eventRateable.rated,
            child: Center(
              child: TextButton(
                onPressed: () {
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return RateDialog(
                          idEvento: widget.eventRateable.event!.id,
                          user: widget.user,
                        );
                      }
                  );
                },
                child: Text('Avaliar'),
              ),
            ),
            replacement: Center(
              child: TextButton(
                onPressed: () {
                   showDialog(context: context,
                      builder: (BuildContext context){
                        return SeeRatingDialog(
                          idEvento: widget.eventRateable.event!.id,
                        );
                      }
                  );
                },
                child: Text('Ver avaliações'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
