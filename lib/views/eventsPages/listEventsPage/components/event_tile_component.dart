// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';

class EventTileComponent {

  static buildEventTileComponent(){
    return Container(
      height: 220,
      padding: EdgeInsets.all(15.0),
      color: CustomColors.colorLightGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // Nome do Evento
          Text(
            'Nome do Evento',
            style: TextStyle(
              color: CustomColors.orangePrimary.shade400,
              fontFamily: 'OpenSans',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),

          // Descrição do evento
          Text(
            'Descrição do evento aqui',
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
                  'Suche Eventos',
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
                SizedBox(width: 10.0,),
                Text(
                  '22/22/2222',
                  style: TextStyle(
                    color: CustomColors.colorOrangeSecondary,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]
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
                  'R\$ 22,22',
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
                    'Rua da Festança, 10, Festival, Garanhuns-PE',
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
                  'Show',
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
