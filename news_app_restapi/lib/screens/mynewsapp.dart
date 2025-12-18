import 'package:flutter/material.dart';
import 'package:news_app_restapi/model/category_data.dart';
import 'package:news_app_restapi/model/news_model.dart';
import 'package:news_app_restapi/screens/caetgory_news.dart';
import 'package:news_app_restapi/screens/news_details.dart';
import 'package:news_app_restapi/service/services.dart';

class MyNewsAppScreen extends StatefulWidget {
  const MyNewsAppScreen({super.key});

  @override
  State<MyNewsAppScreen> createState() => _MyNewsAppScreenState();
}

class _MyNewsAppScreenState extends State<MyNewsAppScreen> {
  List<NewsModel> articles = [];
  List<CategoryNewsModel> categories = [];
  bool isLoading = true;

  Future<void> getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();

    setState(() {
      // ✅ FIX
      isLoading = false;
      articles = newsApi.dataStore;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
    categories = getCategories();
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // for category seltecte:
                  Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final categoysname = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryNewsPage(
                                  category: categoysname.categoryName!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  categoysname.categoryName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // for home screen news
                  ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetails(newsModel: article),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.urlToImage!,
                                  height: 250,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                article.title!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Divider(thickness: 2),
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
