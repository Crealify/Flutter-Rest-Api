import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:news_app_restapi/model/news_model.dart';

class NewsApi {
  List<NewsModel> dataStore = [];
  Future<void> getNews() async {
     dataStore.clear(); // avoid duplicate data

    Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1638c5e8c3534c6a9f22cc757b9264bc",
    );
    // Uri url = Uri.parse(
    //   "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=1638c5e8c3534c6a9f22cc757b9264bc",
    // );
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    print(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element['author'] != null &&
            element["content"] != null) {
          NewsModel newsModel = NewsModel(
            title: element["title"],
            urlToImage: element["urlToImage"],
            description: element["description"],
            author: element["author"],
            content: element["content"],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}

