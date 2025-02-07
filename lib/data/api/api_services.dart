import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail/resto_detail_response.dart';
import 'package:restaurant_app/data/model/home/resto_list_response.dart';
import 'package:restaurant_app/data/model/home/search_resto_response.dart';
import 'package:restaurant_app/data/model/rating/customer_rating_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestoListResponse> getRestoList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestoListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menampilkan daftar restoran :(');
    }
  }

  Future<RestoDetailResponse> getRestoDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestoDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menampilkan detail restoran :(');
    }
  }

  Future<CustomerRatingResponse> postReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
    );

    if (response.statusCode == 201) {
      return CustomerRatingResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Gagal mengirim ulasanmu :(');
    }
  }

  Future<SearchRestoResponse> searchResto(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return SearchRestoResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menampilkan restoran yang dicari :(');
    }
  }
}
