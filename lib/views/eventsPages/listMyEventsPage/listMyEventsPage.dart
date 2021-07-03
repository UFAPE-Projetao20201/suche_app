import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/eventsPages/listEventsPage/components/event_tile_component.dart';

class ListMyEventsPage extends StatefulWidget {
  final User user;

  const ListMyEventsPage({Key? key, required this.user}) : super(key: key);

  @override
  _ListMyEventsPageState createState() => _ListMyEventsPageState();
}

class _ListMyEventsPageState extends State<ListMyEventsPage> {
  bool erro = false;
  bool loading = false;
  var isSelected = [true, false];
  bool imIn = false; //temporário enquanto não há requisção
  bool _switchTypeEventValue = true;
  List<Event> eventList = [];


  error() {
    setState(() {
      loading = false;
      erro = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !erro,
      replacement: Text('erro'),
      child: Container(
        color: CustomColors.colorLightGray,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            // Botão de participante/promotor
            Visibility(
              visible: widget.user.isPromoter, //Negar esse teste
              child: ToggleButtons(
                children: <Widget>[
                  Text("Participante",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                    ),
                  ),
                  Text("Promotor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                    print("Participante / Promotor $isSelected");
                    // Chamar função para listar aqui
                  });
                },
                isSelected: isSelected,
                constraints: BoxConstraints(maxHeight: 45, minHeight: 45, maxWidth: double.infinity, minWidth: 170),
                borderColor: CustomColors.orangePrimary.shade400,
                color: CustomColors.orangePrimary.shade400,
                disabledColor: CustomColors.colorLightGray,
                disabledBorderColor: CustomColors.colorLightGray,
                fillColor: CustomColors.orangePrimary.shade400,
                selectedColor: CustomColors.colorLightGray,
                selectedBorderColor: CustomColors.orangePrimary.shade400,
              ),
            ),
            SizedBox(height: 10,),

            //Botão Switch
            FlutterSwitch(
              width: 150.0,
              height: 45.0,
              toggleSize: 45.0,
              borderRadius: 30.0,
              padding: 8.0,
              valueFontSize: 16,
              showOnOff: true,
              toggleColor: CustomColors.colorLightGray,//
              activeColor: CustomColors.orangePrimary.shade400,
              activeText: "Futuros",
              activeTextColor: CustomColors.colorLightGray,//
              activeTextFontWeight: FontWeight.w900 ,
              inactiveColor: CustomColors.orangePrimary.shade400,
              inactiveText: "Passados",
              inactiveTextColor: CustomColors.colorLightGray,//
              inactiveTextFontWeight: FontWeight.w900,
              value: _switchTypeEventValue,
              onToggle: (val) {
                setState(() {
                  _switchTypeEventValue = !_switchTypeEventValue;
                  print("Mudou switch");
                  // Chamar função para listar aqui
                });
              },
            ),
            SizedBox(height: 10,),
            Divider(
              color: CustomColors.colorOrangeSecondary,
            ),
            Visibility(
              visible: !loading,
              replacement: Flexible(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              child:  Visibility(
                visible: eventList.isNotEmpty,
                replacement: Flexible(
                  child: Center(
                    child: Text(
                      'Não há eventos cadastrados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.orangePrimary.shade400,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                child: Expanded(
                  child:ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            EventTileComponent.buildEventTileComponent(
                              eventList[index], imIn, ),
                            Divider(
                              color: CustomColors.colorOrangeSecondary,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ),
            )
          ],
        ),
      ),
    );
  }
}