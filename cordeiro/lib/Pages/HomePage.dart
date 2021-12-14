import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'FavPage.dart';
import 'ProcurarPage.dart';
import 'TodosPage.dart';

class HomePage extends StatelessWidget {
  get controller => null;

  @override
  Widget build(BuildContext context) {
    var tam = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return DefaultTabController(
        length: 3,
        initialIndex: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: tam.height / 12,
            shadowColor: Colors.yellow,
            bottom: TabBar(indicatorColor: Colors.blue, tabs: <Tab>[
              Tab(
                text: "Favoritos",
              ),
              Tab(
                text: "Procurar",
              ),
              Tab(text: "Ver todos")
            ]),
            title: Image.asset(
              'Images/img01.png',
              height: tam.height / 2,
              width: tam.width,
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            child: _body(context),
          ),
        ));
  }

  _body(BuildContext context) {
    return TabBarView(
      children: <Widget>[FavPage(), ProcurarPage(), TodosPage()],
    );
  }
}
