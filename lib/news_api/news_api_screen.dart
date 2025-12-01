import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = "061dba216c2490bb41a65188930b3019";

  Future<List<dynamic>> fetchNews(String query) async {
    final url =
        "https://gnews.io/api/v4/search?q=$query&lang=en&country=us&max=10&apikey=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["articles"];
    } else {
      throw Exception("Failed to load news");
    }
  }
}
