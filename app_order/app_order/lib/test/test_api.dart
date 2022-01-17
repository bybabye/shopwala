import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_order/models.dart/town.dart';

String api = "https://provinces.open-api.vn/api/?depth=3";
Future<List<Town>> fetchData() async {
  List<Town> towns = [];
  // ignore: unused_local_variable
  var client = http.Client();
  try {
    var url = Uri.parse(api);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      // ignore: avoid_function_literals_in_foreach_calls
      jsonResponse.forEach((element) {
        towns.add(Town.fromJson(element));
      });
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // ignore: avoid_print
    print('${e.toString()} loi o day');
  }

  return towns;
}
