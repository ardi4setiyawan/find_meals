import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<Meal> fetchMeal() async {
    final response = await http
        .get('https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood');

    if (response.statusCode == 200) {
      return Meal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Meals');
    }
  }


class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({this.strMeal, this.strMealThumb, this.idMeal});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
    };
}


void main() {
  runApp(
    FindMeal(),
  );
}

class FindMeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future<Meal> meals;
  @override
  void initState() {
    super.initState();
    meals = fetchMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          color: Colors.black,
          onPressed: () {},
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.black),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: fetchMeal(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(0.8),
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.data.strMeal}"),
                        ],
                      )),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
