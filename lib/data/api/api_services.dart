import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/resto_list_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestoListResponse> getRestoList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if(response.statusCode == 200) {
      return RestoListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant data :(');
    }
  }
}