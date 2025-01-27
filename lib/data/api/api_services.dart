import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/data/model/home/resto_list_response.dart';

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

  Future<RestoDetailResponse> getRestoDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if(response.statusCode == 200) {
      return RestoDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail :(');
    }
  }
}