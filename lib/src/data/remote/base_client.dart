import "package:http/http.dart" as http;

const String baseUrl = "https://jsonplaceholder.typicode.com/";

class BaseClient {
  var client = http.Client();

  // GET ALL
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    // AUTHORIZATION
    var _headers = {
      'Authorization': "Bearer token_goes_here",
      'api_key': "api_key_goes_here"
    };

    var res = await client.get(url, headers: _headers);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      // exception
    }
  }

  Future<dynamic> getOne(String api) async {}
  Future<dynamic> post(String api) async {}
  Future<dynamic> put(String api) async {}
  Future<dynamic> delete(String api) async {}
}
