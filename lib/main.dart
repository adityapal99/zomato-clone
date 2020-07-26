import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

// Custom Widgets
import 'food_tab.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      exit(244);
    }
  };
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ZomatoClone",
      home: SafeArea(child: HomePage()),
      theme: ThemeData(
          backgroundColor: Colors.grey[300],
          appBarTheme:
              AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: Colors.black54))),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = [
    Tab(
      child: Text(
        "food",
        style: TextStyle(fontSize: 24),
      ),
    ),
    Tab(
      child: Text(
        "grocery",
        style: TextStyle(fontSize: 24),
      ),
    ),
    Tab(
      child: Text(
        "self pickup",
        style: TextStyle(fontSize: 24),
      ),
    ),
    Tab(
      child: Text(
        "hotels",
        style: TextStyle(fontSize: 24),
      ),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _appBarController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      extendBody: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       Row(
      //         children: <Widget>[
      //           Icon(Icons.location_on),
      //           Padding(
      //             padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      //             child: Text(
      //               "Halisahar, Kolkata",
      //               style: TextStyle(color: Colors.black54),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Icon(Icons.scanner),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Icon(Icons.payment),
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        controller: _appBarController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Halisahar, Kolkata",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.scanner),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.payment),
                      )
                    ],
                  )
                ],
              ),
            ),
            SliverAppBar(
              pinned: true,
              primary: true,
              floating: true,
              title: Container(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Search for resturants and cuisines...",
                          prefixIcon: Icon(Icons.search),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabled: false,
                          border:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[600]))),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                indicatorWeight: 0.1,
                labelColor: Colors.red[400],
                unselectedLabelColor: Colors.grey[600],
                tabs: this.tabs,
                controller: _tabController,
                isScrollable: true,
              ),
            ),
            // SliverOverlapAbsorber(
            //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            //   sliver: SliverAppBar(
            //     floating: true,
            //     title: Container(
            //       child: Column(
            //         children: <Widget>[
            //           TextFormField(
            //             decoration: InputDecoration(
            //                 labelText: "Search for resturants and cuisines...",
            //                 prefixIcon: Icon(Icons.search),
            //                 floatingLabelBehavior: FloatingLabelBehavior.never,
            //                 border: OutlineInputBorder(
            //                     borderSide: BorderSide(color: Colors.grey[600]))),
            //           ),
            //         ],
            //       ),
            //     ),
            //     bottom: TabBar(
            //       indicatorWeight: 0.1,
            //       labelColor: Colors.red[400],
            //       unselectedLabelColor: Colors.grey[600],
            //       tabs: this.tabs,
            //       controller: _tabController,
            //       isScrollable: true,
            //     ),
            //   ),
            // ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: FoodTabPage(),
            ),
            Center(child: Text("food Section")),
            Center(child: Text("food Section")),
            Center(child: Text("food Section")),
          ],
        ),
      ),
    );
  }
}

// class HomePageBody extends StatefulWidget {
//   @override
//   _HomePageBody createState() {
//     return _HomePageBody();
//   }
// }

// class _HomePageBody extends State<HomePageBody> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//               child: Container(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
