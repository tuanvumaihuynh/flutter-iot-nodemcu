import 'dart:convert';
import 'package:rtbd_nodemcu_project/models/date_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<DateModel>> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://script.google.com/macros/s/AKfycbxa58LCnJkiC4H1J72PBnYiEm7QDBCysmeI5UZZuj6VHE2zP06iYMDMDac8lT-nnHu-WA/exec');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return dateModelFromJson(json);
    }
    return [];
  }
}
