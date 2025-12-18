import 'package:flutter/material.dart';
import 'package:news_app_restapi/model/category_data.dart';
import 'package:news_app_restapi/model/news_model.dart';
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

  getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();

    setState(() {
      // ✅ FIX
      isLoading = false;
      articles = newsApi.dataStore;
      categories = getCategories();
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
      body: isLoading
          ? SizedBox(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // for category seltecte:
                  Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),

                  // for home screen news
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
                  ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final articles = categories[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          // margin: EdgeInsets.center
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              articles.categoryName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
