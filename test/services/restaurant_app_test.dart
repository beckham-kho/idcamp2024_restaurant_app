import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/data/model/home/resto_list_response.dart';
import 'package:restaurant_app/data/model/home/search_resto_response.dart';
import 'package:restaurant_app/data/model/rating/customer_rating_response.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/providers/rating/post_rating_provider.dart';
import 'package:restaurant_app/static/post_rating_result_state.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';
import 'package:restaurant_app/static/search_resto_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late RestoListProvider restoListProvider;
  late PostRatingProvider postRatingProvider;
  late SearchRestoProvider searchRestoProvider;

  setUp(() {
    apiServices = MockApiServices();
    restoListProvider = RestoListProvider(apiServices);
    postRatingProvider = PostRatingProvider(apiServices);
    searchRestoProvider = SearchRestoProvider(apiServices);
  });

  test("Harus mengembalikan data list restoran sesuai dengan format model RestoListResponse()", () async {
    final dummyRestoListResponse = RestoListResponse(
      error: false,
      message: "",
      count: 0,
      restaurants: [],
    );

    when(() => apiServices.getRestoList()).thenAnswer((_) async => dummyRestoListResponse);

    final result = await apiServices.getRestoList();

    expect(result, isA<RestoListResponse>());
  });

  test("Harus mengembalikan nilai state PostRatingSuccessState jika tipe post rating berhasil", () async {
    final dummyCustomerRatingResponse = CustomerRatingResponse(
      error: false,
      message: "",
      customerReviews: [],
    );

    when(() => apiServices.postReview('rqdv5juczeskfw1e867', 'John Doe', 'Mantap banget!')).thenAnswer((_) async => dummyCustomerRatingResponse);

    await postRatingProvider.postRating('rqdv5juczeskfw1e867', 'John Doe', 'Mantap banget!');
    final resultState = postRatingProvider.resultState;

    expect(resultState, isA<PostRatingSuccessState>());
  });

  group("resto list provider", () {
    test("Harus mengembalikan nilai state RestoListNoneState ketika awal provider resto list", () {
      final initState = restoListProvider.resultState;

      expect(initState, isA<RestoListNoneState>());
    });

    test("Harus mengembalikan data bertipe <List<Restaurant>> jika fetching API berhasil", () async {
      final dummyRestoListResponse = RestoListResponse(
        error: false,
        message: "",
        count: 0,
        restaurants: [],
      );

      when(() => apiServices.getRestoList()).thenAnswer((_) async => dummyRestoListResponse);

      await restoListProvider.fetchRestoList();
      final resultState = restoListProvider.resultState;

      if(resultState is RestoListLoadedState) {
        final restoList = resultState.data;

        expect(resultState, isA<RestoListLoadedState>());
        expect(restoList, isA<List<Restaurant>>());
      }
    });

    test("Harus mengembalikan satu nama restoran 'Melting Pot' jika parameter search 'Melting Pot'" , () async {
      final dummySearchRestoResponse = SearchRestoResponse(
        error: false,
        founded: 0,
        restaurants: [],
      );

      when(() => apiServices.searchResto("Melting Pot")).thenAnswer((_) async => dummySearchRestoResponse);

      await searchRestoProvider.fetchSearchResto("Melting Pot");
      final resultState = searchRestoProvider.resultState;

      if(resultState is SearchRestoLoadedState) {
        final resto = resultState.data;
        final restoName = resto.first.name;

        expect(resultState, isA<SearchRestoLoadedState>());
        expect(restoName, "Melting Pot");
      }
    });
  });
}