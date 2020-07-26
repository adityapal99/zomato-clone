import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sortedmap/sortedmap.dart';

class FoodTabPage extends StatelessWidget {
  List<String> listOfItemsFromJson() {
    List<String> listOfItems = [];

    Map<String, dynamic> items = jsonDecode("""{
      "Biryani": 432,
      "Chowmein": 321,
      "Rolls": 442,
      "Paratha": 45,
      "Momos": 265,
      "Salad": 24,
      "Ice Cream": 129,
      "Chicken": 656
    }""");
    listOfItems.addAll(items.keys.toList());

    var sorted = SortedMap(Ordering.byValue());
    sorted.addAll(items);

    return listOfItems;
  }

  Widget build(BuildContext context) {
    ScrollController _covidSecurityController = ScrollController();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            // Container for popular recipes
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Lockdown cravings",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Most ordered in your city",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14, letterSpacing: 0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopularRecipeGrid()
                ],
              ),
            ),

            // Places delivering to you
            Container(child: PlacesThatServe()),
          ],
        ),
      ),
    );
  }
}

class PlacesThatServe extends StatefulWidget {
  @override
  _PlacesThatServeState createState() => _PlacesThatServeState();
}

class _PlacesThatServeState extends State<PlacesThatServe> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController scrollController = ScrollController();
  // Map loadJsonData() {
  //   var file = DefaultAssetBundle.of(context).loadString("sample/places.json");
  //   var jsonData = json.decode(file.)
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "6 places delivering to you",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Most ordered in your city",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, letterSpacing: 0.7),
                ),
              ],
            ),
            NestedScrollView(
                headerSliverBuilder: (context, innerBoxScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: Container(
                        child: Text("Filters"),
                      ),
                    )
                  ];
                },
                body: null)
          ],
        ),
      ),
    );
  }
}

class RecipeButtons extends StatefulWidget {
  String item;

  RecipeButtons({Key key, this.item}) : super(key: key);

  @override
  _RecipeButtons createState() => _RecipeButtons(this.item);
}

class _RecipeButtons extends State<RecipeButtons> {
  bool _pressed = false;
  String item;

  _RecipeButtons(this.item);

  void onTapDetection() {
    if (!_pressed) {
      print(this.item);
      _pressed = !_pressed;
    } else {
      _pressed = !_pressed;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapDetection,
      child: Container(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset("assets/images/recipes/${item.toLowerCase()}.jpg"),
                ),
                width: MediaQuery.of(context).size.width / 5.2,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${item}"),
              ),
            ],
          )
        ],
      )),
    );
  }
}

class PopularRecipeGrid extends StatefulWidget {
  @override
  _PopularRecipeGridState createState() => _PopularRecipeGridState();
}

class _PopularRecipeGridState extends State<PopularRecipeGrid> {
  List<String> listOfItemsFromJson() {
    List<String> listOfItems = [];

    Map<String, dynamic> items = jsonDecode("""{
      "Biryani": 432,
      "Chowmein": 321,
      "Rolls": 442,
      "Paratha": 45,
      "Momos": 265,
      "Salad": 24,
      "Ice Cream": 129,
      "Chicken": 656
    }""");
    listOfItems.addAll(items.keys.toList());

    var sorted = SortedMap(Ordering.byValue());
    sorted.addAll(items);

    return listOfItems;
  }

  bool showMore = false;
  List<Widget> gridWidgets;

  @override
  void initState() {
    super.initState();
    setState(() {
      showMore = false;
      gridWidgets = listOfItemsFromJson()
          .map((item) {
            return RecipeButtons(item: item);
          })
          .toList()
          .sublist(0, 4);
    });
  }

  void showMoreTap() {
    setState(() {
      if (!showMore) {
        showMore = true;
        gridWidgets = listOfItemsFromJson().map((item) {
          return RecipeButtons(item: item);
        }).toList();
      } else {
        showMore = false;
        gridWidgets = listOfItemsFromJson()
            .map((item) {
              return RecipeButtons(item: item);
            })
            .toList()
            .sublist(0, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          GridView.count(
            childAspectRatio: 0.8,
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            children: this.gridWidgets,
          ),
          Container(
              child: Material(
            child: MaterialButton(
              onPressed: this.showMoreTap,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("show more"),
                    Icon(this.showMore ? Icons.arrow_upward : Icons.arrow_downward)
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
