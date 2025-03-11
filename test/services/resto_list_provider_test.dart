import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/general/restaurant.dart';
import 'package:restaurant_app/data/model/home/resto_list_response.dart';
import 'package:restaurant_app/providers/home/resto_list_provider.dart';
import 'package:restaurant_app/static/resto_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late RestoListProvider restoListProvider;

  setUp(() {
    apiServices = MockApiServices();
    restoListProvider = RestoListProvider(apiServices);
  });

  group("resto list provider", () {
    test("Harus mengembalikan nilai state awal RestoListNoneState", () {
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
      final restoListLoadedState = resultState as RestoListLoadedState;
      final restoList = restoListLoadedState.data;

      expect(resultState, isA<RestoListLoadedState>());
      expect(restoList, isA<List<Restaurant>>());
    });

    test("Harus mengembalikan Exception jika fetching API gagal" , () async {
      when(() => apiServices.getRestoList()).thenThrow(Exception('Gagal menampilkan daftar restoran :('));

      await restoListProvider.fetchRestoList();
      final resultState = restoListProvider.resultState;
      final errorState = resultState as RestoListErrorState;

      expect(resultState, isA<RestoListErrorState>());
      expect(errorState.error, "Terjadi kesalahan. Silakan coba lagi :(");
    });
  });
}