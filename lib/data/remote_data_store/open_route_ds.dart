import 'package:http/http.dart';
import 'package:wheelmap/common/manager/networking/network_client.dart';

class OpenRouteDataSource {
  //Creating Singleton
  OpenRouteDataSource._privateConstructor();
  static final OpenRouteDataSource _apiResponse =
      OpenRouteDataSource._privateConstructor();
  factory OpenRouteDataSource() => _apiResponse;

  NetworkClient client = NetworkClient(
    Client(),
  );

  /// Example request. Please take a look how you can use the api and client.
  // Future<Result> getBooks() async {
  //   try {
  //     final response =
  //         await client.request(requestType: RequestType.GET, path: "books");
  //     if (response.statusCode == 200) {
  //       return Result<Feature>.success(
  //         Feature.fromJson(
  //           jsonDecode(
  //             response.body,
  //           ),
  //         ),
  //       );
  //     } else {
  //       return Result.error("Book list not available");
  //     }
  //   } catch (error) {
  //     return Result.error("Something went wrong!");
  //   }
  // }
}
