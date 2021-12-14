import 'package:cordeiropotiguar/controler/MostrarTodos.dart';
import 'package:cordeiropotiguar/controler/model/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Servicos.dart';
import 'DetalhesPokemon.dart';
import 'LoginPage.dart';

class ProcurarPage extends StatefulWidget {
  @override
  _ProcurarPageState createState() => _ProcurarPageState();
}

class _ProcurarPageState extends State<ProcurarPage> {
  final controlerbusca = TextEditingController();
  List<Pokemon> listP = new List();
  var text = 'pikachu';

  @override
  void initState() {
    super.initState();
  }

  void _exibirlista(nome) {
    if (nome != null) {
      receberPokemonPesquisa(nome).then((value) {
        if (value != null) {
          setState(() {
            listP = value;
          });
        }
      });
    }
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
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  _exibirlista(controlerbusca.text);
                },
                icon: Icon(Icons.search))
          ],
          title: TextField(
            controller: controlerbusca,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Procurar Pokemon"),
            ),
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: listP.length,
            itemBuilder: (context, index) {
              return (Card(
                  color: Colors.white12,
                  child: ListTile(
                      onTap: () => _exibePokemon(listP[index]),
                      subtitle: Text("${listP[index].types[0].type.name}"),
                      title:
                          Text("${listP[index].id} - ${listP[index].name}"))));
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
