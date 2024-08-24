import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:irusriproject/models/country.dart';
import 'package:irusriproject/services/rest_client.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('RestClient Test', () {
    late MockDio dio;
    late RestClient client;

    setUp(() {
      dio = MockDio();
      client = RestClient(dio);
    });

    test('fetch European countries', () async {
      const url =
          'https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population';

      when(dio.get(url)).thenAnswer((_) async => Response(
            data: [
              {
                "name": {"common": "Norway", "official": "Kingdom of Norway"},
                "capital": ["Oslo"],
                "flags": {
                  "png": "https://flagcdn.com/w320/no.png",
                  "svg": "https://flagcdn.com/no.svg",
                  "alt": "The flag of Norway"
                },
                "region": "Europe",
                "languages": {
                  "nno": "Norwegian Nynorsk",
                  "nob": "Norwegian Bokmål",
                  "smi": "Sami"
                },
                "population": 5379475
              }
            ],
            statusCode: 200,
            requestOptions: RequestOptions(path: url),
          ));

      final countries = await client.getEuropeanCountries();
      expect(countries, isA<List<Country>>());
      expect(countries.length, greaterThan(0));
    });
  });
}
