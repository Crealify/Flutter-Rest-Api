import 'package:flutter/material.dart';
import 'package:news_app_restapi/model/news_model.dart';
import 'package:news_app_restapi/service/services.dart';

class MyNewsAppScreen extends StatefulWidget {
  const MyNewsAppScreen({super.key});

  @override
  State<MyNewsAppScreen> createState() => _MyNewsAppScreenState();
}

class _MyNewsAppScreenState extends State<MyNewsAppScreen> {
  List<NewsModel> articles = [];
  
  getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();

    setState(() {
      // ✅ FIX
      articles = newsApi.dataStore;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.network(
                          article.urlToImage!,
                          height: 250,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          article.title!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
