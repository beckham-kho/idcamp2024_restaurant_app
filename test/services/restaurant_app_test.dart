import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/data/model/home/resto_list_response.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/providers/rating/post_rating_provider.dart';
import 'package:restaurant_app/static/post_rating_result_state.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';
import 'package:restaurant_app/static/search_resto_result_state.dart';

void main() {
  late ApiServices apiServices;
  late RestoListProvider restoListProvider;
  late PostRatingProvider postRatingProvider;
  late SearchRestoProvider searchRestoProvider;

  setUp(() {
    apiServices = ApiServices();
    restoListProvider = RestoListProvider(apiServices);
    postRatingProvider = PostRatingProvider(apiServices);
    searchRestoProvider = SearchRestoProvider(apiServices);
  });

  test("Harus mengembalikan data list restoran sesuai dengan format model RestoListResponse()", () async {
    final result = await apiServices.getRestoList();

    expect(result, isA<RestoListResponse>());
  });

  test("Harus mengembalikan nilai state PostRatingSuccessState jika tipe post rating berhasil", () async {
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
      await restoListProvider.fetchRestoList();
      final resultState = restoListProvider.resultState;

      if(resultState is RestoListLoadedState) {
        final restoList = resultState.data;

        expect(resultState, isA<RestoListLoadedState>());
        expect(restoList, isA<List<Restaurant>>());
      }
    });

    test("Harus mengembalikan satu nama restoran 'Melting Pot' jika parameter search 'Melting Pot'" , () async {
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