import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:weather_app/src/models/index.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[AppState, Location, OpenWeather, Details, Weather])
Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
