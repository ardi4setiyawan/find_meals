import 'package:flutter/material.dart';
import 'dart:async';
import 'data.dart';
import 'details.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ListCategories> categories;
  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
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
        body: FutureBuilder(
          future: fetchCategories(),
          builder: (context, snapshot) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.listcategories.length,
              itemBuilder: (context, index) {
                var data = snapshot.data.listcategories[index];
                return snapshot.data.listcategories == null
                    ? Text('No Meals Found.')
                    : InkWell(

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                      },
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(data.strCategoryThumb,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 40.0,
                                  color: Colors.grey.withOpacity(0.7),
                                  width: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Text(
                                      data.strCategory,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              },
            );
          },
        ));
  }
}
