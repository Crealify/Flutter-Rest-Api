import 'package:news_app_restapi/model/news_model.dart';

List<CategoryNewsModel> getCategories() {
  //news category list
  List<CategoryNewsModel> categories = [];

  CategoryNewsModel category = CategoryNewsModel();
  category.categoryName = "science";

  categories.add(category);

  category = CategoryNewsModel();
  category.categoryName = "sports";
  categories.add(category);

  category = CategoryNewsModel();
  category.categoryName = "business";
  categories.add(category);
  category = CategoryNewsModel();
  category.categoryName = "general";
  categories.add(category);

  category = CategoryNewsModel();
  category.categoryName = "entertainment";
  categories.add(category);

  return categories;
}
