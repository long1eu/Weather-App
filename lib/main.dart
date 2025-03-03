import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:weather_app/src/actions/index.dart';
import 'package:weather_app/src/data/location_api.dart';
import 'package:weather_app/src/data/weather_api.dart';
import 'package:weather_app/src/epics/app_epic.dart';
import 'package:weather_app/src/models/index.dart';
import 'package:weather_app/src/presentation/home_page.dart';
import 'package:weather_app/src/reducer/reducer.dart';

// TODO(ursachecodrut): not used
const String API_KEY_WEATHER = '01c9b6a7efc52483cd7bf1c892b3309f';

void main() {
  const String locationApiUrl = 'http://ip-api.com/json/?fields=61439';
  const String weatherApiUrl = 'https://api.openweathermap.org/data/2.5/onecall';
  final Client client = Client();
  final LocationApi locationApi = LocationApi(apiUrl: locationApiUrl, client: client);
  final WeatherApi weatherApi = WeatherApi(apiUrl: weatherApiUrl, client: client);
  final AppEpic appEpic = AppEpic(locationApi: locationApi, weatherApi: weatherApi);
  // TODO(ursachecodrut): not used
  // final AppMiddleware appMiddleware = AppMiddleware(locationApi: locationApi, weatherApi: weatherApi);
  final Store<AppState> store = Store<AppState>(reducer, initialState: AppState(),
      // TODO(ursachecodrut): not used
      // middleware: appMiddleware.middleware,
      // TODO(ursachecodrut): comma
      middleware: <Middleware<AppState>>[EpicMiddleware<AppState>(appEpic.epic)]);
  store.dispatch(const GetLocation());

  runApp(WeatherApp(store: store));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          // TODO(ursachecodrut): comma
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.deepPurple),
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
