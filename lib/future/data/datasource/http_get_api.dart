import 'package:http/http.dart' as http;

class HttpApi {
  HttpApi();

  Future<http.Response> getCharacterHttp() async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character');
    final result = await http.get(url);
    // print(result.body);
    return result;
  }
}
