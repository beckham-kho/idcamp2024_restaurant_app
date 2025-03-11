import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/data/model/home/search_resto_response.dart';
import 'package:restaurant_app/providers/home/search_resto_provider.dart';
import 'package:restaurant_app/static/search_resto_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late SearchRestoProvider searchRestoProvider;

  setUp(() {
    apiServices = MockApiServices();
    searchRestoProvider = SearchRestoProvider(apiServices);
  });

  group("Search resto provider", () {
    test("Harus mengembalikan nilai state awal SearchRestoNoneState", () {
      final initState = searchRestoProvider.resultState;

      expect(initState, isA<SearchRestoNoneState>());
    });

    test("Harus mengembalikan satu nama restoran 'Melting Pot' jika parameter search 'Melting Pot'" , () async {
      final dummySearchRestoResponse = SearchRestoResponse(
        error: false,
        founded: 1,
        restaurants: [
          Restaurant.fromJson({
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }),
        ],
      );

      when(() => apiServices.searchResto("Melting Pot")).thenAnswer((_) async => dummySearchRestoResponse);

      await searchRestoProvider.fetchSearchResto("Melting Pot");
      final resultState = searchRestoProvider.resultState;
      final searchRestoLoadedState = resultState as SearchRestoLoadedState;
      final searchedRestoName = searchRestoLoadedState.data.first.name;

      expect(resultState, isA<SearchRestoLoadedState>());
      expect(searchedRestoName, "Melting Pot");
    });
  });
}