// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class NewsService {
//   final String apiKey = "6dd495ab1e9c320904c88e2a8d224797";
//
//
//   Future<List<dynamic>> fetchNews(String query) async {
//     final url =
//         "https://gnews.io/api/v4/top-headlines?category=general&lang=en&max=10&apikey=$apiKey";
//
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data["articles"];
//     } else {
//       throw Exception("Failed to load news");
//     }
//   } }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class NewsService {
//   final String apiKey = "a98463ded96d403c95850fc7e511d306";
//
//   Future<List<dynamic>> fetchNews(String query) async {
//     final url =
//         "https://newsapi.org/v2/everything?q=$query&from=2025-11-01&sortBy=publishedAt&apiKey=$apiKey";
//
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data["articles"]; // Returns list of news articles
//     } else {
//       print("Status Code: ${response.statusCode}");
//       print("Body: ${response.body}");
//       throw Exception("Failed to load news");
//     }
//   }
// }
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class NewsService {
//   final String apiKey = "6dd495ab1e9c320904c88e2a8d224797";
//
//
//   Future<List<dynamic>> fetchNews() async {
//     final url = Uri.parse(
//         "https://gnews.io/api/v4/top-headlines?category=general&lang=en&max=10&apikey=$apiKey");
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["articles"]; // article list return hogi
//     } else {
//       throw Exception("Failed to load news");
//     }
//   }
// }
//
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = "6dd495ab1e9c320904c88e2a8d224797";

  Future<List<dynamic>> fetchNews(String query) async {
    // Map your friendly category names to GNews API categories if needed
    String category = query.toLowerCase();
    if (category == "top") category = "general";
    if (category == "hum tv" || category == "ary news" || category == "geo news") {
      category = "general"; // GNews doesn’t support these, fallback to general
    }

    final url =
        "https://gnews.io/api/v4/top-headlines?category=$category&lang=en&max=10&apikey=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["articles"];
    } else {
      throw Exception("Failed to load news: ${response.statusCode}");
    }
  }
}
