import 'package:cordeiropotiguar/controler/MostrarTodos.dart';
import 'package:cordeiropotiguar/controler/model/pokemon.dart';
import 'package:flutter/material.dart';

import '../Servicos.dart';
import 'DetalhesPokemon.dart';
import 'LoginPage.dart';

class TodosPage extends StatefulWidget {
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
// ignore: deprecated_member_use
  List<Pokemon> listP = new List();
  bool recarregar = true;
  String tipoini = "todos";

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
        appBar: AppBar(
          title: Row(children: [
            ActionChip(
                label: Text("todos"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "todos";
                    recarregar = !recarregar;
                  });
                }),
            ActionChip(
                label: Text("normal"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "normal";
                    recarregar = !recarregar;
                  });
                  ;
                }),
            ActionChip(
                label: Text("grass"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "grass";
                    recarregar = !recarregar;
                  });
                }),
            ActionChip(
                label: Text("Fire"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "fire";
                    recarregar = !recarregar;
                  });
                }),
            ActionChip(
                label: Text("water"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "water";
                    recarregar = !recarregar;
                  });
                  ;
                }),
            ActionChip(
                label: Text("bug"),
                onPressed: () async {
                  showSnackbar(context);
                  setState(() {
                    tipoini = "bug";
                    recarregar = !recarregar;
                  });
                }),
          ]),
        ),
        body: recarregar ? _buiderFilter(tipoini) : _buiderFilter(tipoini));
  }

  exibePokemon(
    Pokemon pokemon,
  ) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetalhesPokemon(pokemon: pokemon)));
  }

  _buiderFilter(tipo) {
    List<Pokemon> listP = new List();
    print(tipo);

    return FutureBuilder(
        future: receberPokemons(tipo),
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
                        onTap: () => exibePokemon(listP[index]),
                        subtitle: Text("${listP[index].types[0].type.name}"),
                        title: Text(
                            "${listP[index].id} - ${listP[index].name}"))));
              });
        });
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      content: Text("Carregando, Aguarde!"),
    ));
  }
}
