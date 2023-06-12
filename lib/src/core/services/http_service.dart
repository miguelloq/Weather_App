import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
    Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Future.error('Status code is not 200');
    }
  }
}