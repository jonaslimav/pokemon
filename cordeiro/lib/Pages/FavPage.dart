import 'package:cordeiropotiguar/controler/Favoritos.dart';
import 'package:cordeiropotiguar/controler/MostrarTodos.dart';
import 'package:cordeiropotiguar/controler/model/pokemon.dart';
import 'package:flutter/material.dart';

import '../Servicos.dart';
import 'DetalhesPokemon.dart';
import 'LoginPage.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  List<Pokemon> listP = new List();
  Favoritos fav = new Favoritos();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Text("Sair"),
          onPressed: () async {
            limparStorage();

            await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false);
          }),
    );
  }

  _body(BuildContext context) {
    return new Scaffold(
        body: FutureBuilder(
            future: receberPokemonsF(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              listP = snapshot.data;
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: listP.length,
                  itemBuilder: (context, index) {
                    return (Card(
                        color: Colors.white12,
                        child: ListTile(
                            onTap: () => _exibePokemon(listP[index]),
                            subtitle:
                                Text("${listP[index].types[0].type.name}"),
                            title: Text(
                                "${listP[index].id} - ${listP[index].name}"))));
                  });
            }));
  }

  _exibePokemon(
    Pokemon pokemon,
  ) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetalhesPokemon(pokemon: pokemon)));
  }
}
