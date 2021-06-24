// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/event_provider.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/eventsPages/listEventsPage/components/event_tile_component.dart';

class ListEventsPage extends StatefulWidget {
  final User user;

  const ListEventsPage({Key? key, required this.user}) : super(key: key);

  @override
  _ListEventsPageState createState() => _ListEventsPageState();
}

class _ListEventsPageState extends State<ListEventsPage> {
  bool _switchTypeEventValue = true;
  List<Event> eventList = [];
  bool erro = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    setState(() {
      loading = true;
    });

    if(_switchTypeEventValue){
      await getPresentialEvent();
    } else {
      await getOnlineEvent();
    }

    setState(() {
      loading = false;
    });
  }

  getPresentialEvent() async {
    print('carregando getPresentialEvent');

    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {
      var eventListResponse = await _apiClient.listPresentialEvents();

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
      print(eventList.isEmpty);
      print(eventList.length);
    } on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  getOnlineEvent() async {
    print('carregando getOnlineEvent');
    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {
      var eventListResponse = await _apiClient.listOnlineEvents();

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
      print(eventList.isEmpty);
      print(eventList.length);
    } on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  error() {
    setState(() {
      loading = false;
      erro = true;
    });
  }


  // listEvents

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
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Eventos',
                style: TextStyle(
                  color: CustomColors.orangePrimary.shade400,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20.0),
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
                activeText: "Prensencial",
                activeTextColor: CustomColors.colorLightGray,//
                activeTextFontWeight: FontWeight.w900 ,
                inactiveColor: CustomColors.orangePrimary.shade400,
                inactiveText: "Virtual",
                inactiveTextColor: CustomColors.colorLightGray,//
                inactiveTextFontWeight: FontWeight.w900,
                value: _switchTypeEventValue,
                onToggle: (val) {
                  setState(() {
                    _switchTypeEventValue = !_switchTypeEventValue;
                    getEvents();
                  });
                },
              ),
              SizedBox(height: 20.0),
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
                                  eventList[index]),
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

          )
      ),
    );
  }
}
