import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ListCategories> fetchCategories() async {
  final response =
      await http.get('https://www.themealdb.com/api/json/v1/1/categories.php');

  if (response.statusCode == 200) {
    return ListCategories.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Meals');
  }
}

ListCategories getList(String str) => ListCategories.fromJson(json.decode(str));

class ListCategories {
  List<Categories> listcategories;

  ListCategories({this.listcategories});
  factory ListCategories.fromJson(Map<String, dynamic> json) => ListCategories(
      listcategories: List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))));
}

class Categories {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Categories(
      {this.idCategory,
      this.strCategory,
      this.strCategoryThumb,
      this.strCategoryDescription});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      idCategory: json['idCategory'],
      strCategory: json['strCategory'],
      strCategoryThumb: json['strCategoryThumb'],
      strCategoryDescription: json['strCategoryDescription'],
    );
  }

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
