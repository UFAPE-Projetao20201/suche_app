// Flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:mdi/mdi.dart';
import 'package:suche_app/model/event.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';

class EventTileComponent {
  static buildEventTileComponent(Event event, bool imIn,
      {Function(bool?)? onChangedImIn}) {
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
            event.name,
            style: TextStyle(
              color: CustomColors.orangePrimary.shade400,
              fontFamily: 'OpenSans',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),

          // Descrição do evento
          Text(
            event.description,
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
              event.promoter == null
                  ? 'Não informado'
                  : event.promoter!.name +
                      ' ' +
                      event.promoter!.surname, // NULLABLE ??
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
                DateFormat('dd/MM/yyyy – HH:mm').format(event.date),
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
              Util.toMoney(event.value),
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
            visible: event.localization != null,
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
                  event.localization == null
                      ? 'Não informado'
                      : event.localization!.street +
                          ', Nº ' +
                          event.localization!.number.toString() +
                          ' - ' +
                          event.localization!.city, // NULLABLE ??
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
                  event.link, // NULLABLE ??
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
              event.category,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: imIn,
                    onChanged:(_){},
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
        ],
      ),
    );
  }
}
