import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  late String location; // location name for the UI
  late String time; // time at location
  late String flag; // url for flag icon
  late String url; // location url for api endpoint

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    time = now.toString();
  }

}