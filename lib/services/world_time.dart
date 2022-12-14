import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {

  late String location; // location name for the UI
  late String time; // time at location
  late String flag; // url for flag icon
  late String url; // location url for api endpoint
  bool isDaytime = false;

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime =  6 < now.hour && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (error) {
      print('Caught error: $error');
      time = 'Could not get time data';
    }

  }

}