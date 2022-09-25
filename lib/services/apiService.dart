import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:together/models/articleModel.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();
  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': '4fcf6bd24d3c40d99f12c609b3bb0297'
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];

    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

    print(articles);
    return articles;
  }
}
