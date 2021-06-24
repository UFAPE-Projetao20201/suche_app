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

  static buildEventTileComponent(Event event){
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
                fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(height: 5.0),

          //Promotor do evento
          Row(
              children: <Widget>[
                Icon(
                  Mdi.accountOutline,
                  color: CustomColors.colorOrangeSecondary,
                ),
                SizedBox(width: 10.0,),
                Text(
                  event.promoter == null ? 'Não informado' : event.promoter!.name + ' ' + event.promoter!.surname, // NULLABLE ??
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]
          ),

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
          Row(
              children: <Widget>[
                Icon(
                  Mdi.cash,
                  color: CustomColors.colorOrangeSecondary,
                ),
                SizedBox(width: 10.0,),
                Text(
                  Util.toMoney(event.value),
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ]
          ),

          //Local do evento
          Row(
              children: <Widget>[
                Icon(
                  Mdi.mapMarker,
                  color: CustomColors.colorOrangeSecondary,
                ),
                SizedBox(width: 10.0,),
                Flexible(
                  child: Text(
                    event.localization == null ? 'Não informado' : event.localization!.street + ', Nº ' + event.localization!.number.toString() + ' - ' + event.localization!.city, // NULLABLE ??
                    style: TextStyle(
                      color: CustomColors.colorOrangeSecondary,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]
          ),

          //Categoria do evento
          Row(
              children: <Widget>[
                Icon(
                  Mdi.formatListChecks,
                  color: CustomColors.colorOrangeSecondary,
                ),
                SizedBox(width: 10.0,),
                Text(
                  event.category,
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  ),
                ),
              ]
          ),

        ],
      ),
    );
  }
}
