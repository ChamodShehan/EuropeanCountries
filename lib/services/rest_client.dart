import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/country.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://restcountries.com/v3.1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/region/europe?fields=name,capital,flags,region,languages,population")
  Future<List<Country>> getEuropeanCountries();
}
