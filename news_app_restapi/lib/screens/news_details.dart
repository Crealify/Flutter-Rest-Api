// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app_restapi/model/news_model.dart';

class NewsDetails extends StatelessWidget {
  final NewsModel newsModel;
  const NewsDetails({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            newsModel.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              Expanded(child: SizedBox()),
              Spacer(),
              Expanded(child: Text("- ${newsModel.author!}", maxLines: 1)),
            ],
          ),
          SizedBox(height: 10),
          Image.network(newsModel.urlToImage!),
          SizedBox(height: 10),
          Text(newsModel.content!, style: TextStyle(fontSize: 18)),
          Text(newsModel.description!, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
