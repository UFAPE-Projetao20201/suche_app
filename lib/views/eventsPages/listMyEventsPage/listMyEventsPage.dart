// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/model/event_rateable.dart';

// Project imports:
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/event_provider.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/eventsPages/listMyEventsPage/components/event_tile_comum_component.dart';

import 'components/event_tile_rateable_component.dart';

class ListMyEventsPage extends StatefulWidget {
  final User user;

  const ListMyEventsPage({Key? key, required this.user}) : super(key: key);

  @override
  _ListMyEventsPageState createState() => _ListMyEventsPageState();
}

class _ListMyEventsPageState extends State<ListMyEventsPage> {
  bool erro = false;
  bool loading = false;
  var isSelected = [true, false]; //index 0 para promotor e index 1 para participante
  bool imIn = false; //temporário enquanto não há requisção
  bool _switchTypeEventValue = true; // true é referente a eventos futuros
  List<Event> eventList = [];
  List<EventRateable> eventRateableList = [];

  @override
  void initState() {
    if(!widget.user.isPromoter){
      isSelected = [false, true]; //index 0 para promotor e index 1 para participante
    }
    super.initState();
    getEvents();
  }

  getEvents() async {
    setState(() {
      loading = true;
    });
    //Verifica se é participante
    if(isSelected[1] == true){
      //Verifica se quer ver os eventos que confirmou presença
      if(_switchTypeEventValue){
        await getConfirmedEvents();
      }
      //Verifica se quer ver os eventos que já participou no passado
      else{
        await getPastEvents();
      }
    }
    //Caso seja promotor
    else if(isSelected[0] == true){
      //Verifica se quer ver os eventos futuros cadastrado pelo promotor
      if(_switchTypeEventValue){
        await getFutureEventsPromoter();
      }
      //Verifica se quer ver os eventos cadastrado pelo promotor que já aconteceram
      else{
        await getPastEventsPromoter();
      }
    }

    setState(() {
      loading = false;
    });
  }

  getConfirmedEvents() async {
    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {

      var eventListResponse = await _apiClient.listConfirmedEvents(widget.user.email);

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
    }on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  getPastEvents() async {
    setState(() {
      eventList = [];
      eventRateableList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {

      var eventListResponse = await _apiClient.listPastEvents(widget.user.email);

      // log(eventListResponse.toString());

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          print(eventListResponse[i]);
          EventRateable event = EventRateable.fromJson(eventListResponse[i]);
          eventRateableList.add(event);
        }
      });
    }on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  getFutureEventsPromoter() async {
    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {

      var eventListResponse = await _apiClient.listFutureEventsPromoter(widget.user.email);

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
    }on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  getPastEventsPromoter() async {
    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {

      var eventListResponse = await _apiClient.listPastEventsPromoter(widget.user.email);

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
    }on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  error() {
    setState(() {
      loading = false;
      erro = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Visibility(
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
                    Text("Promotor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                      ),
                    ),
                    Text("Participante",
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
                      getEvents();
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
                    print("Mudou switch: $_switchTypeEventValue");
                    getEvents();
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
                  visible: isSelected[1] == true && _switchTypeEventValue == false ? eventRateableList.isNotEmpty : eventList.isNotEmpty,
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
                      itemCount: isSelected[1] == true && _switchTypeEventValue == false ? eventRateableList.length : eventList.length,
                      itemBuilder: (context, index) {
                        if(isSelected[1] == true && _switchTypeEventValue == false) {
                          print(eventRateableList[index]);
                          return ListTile(
                            title: Column(
                              children: [
                                EventTileRateableComponent(eventRateable: eventRateableList[index], user: widget.user),
                                Divider(
                                  color: CustomColors.colorOrangeSecondary,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Column(
                              children: [
                                EventTileComumComponent(event: eventList[index], user: widget.user),
                                Divider(
                                  color: CustomColors.colorOrangeSecondary,
                                ),
                              ],
                            ),
                          );
                        }

                      },
                    ),
                  ),
              ),
              )
            ],
          ),
        ),
      ),
        floatingActionButton: Visibility(
            visible: widget.user.isPromoter && isSelected[0] == true,
            child: FloatingActionButton.extended(
              key: Key("ButtonCadastro"),
              onPressed: () => Navigator.of(context).pushNamed(registerEventRoute, arguments: widget.user),
              label: const Text(
                "Criar Evento",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
              ),
              icon: const Icon(Mdi.plus),
            )
        )
    );
  }
}
