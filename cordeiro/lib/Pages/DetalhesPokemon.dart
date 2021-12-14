import 'package:cordeiropotiguar/controler/Favoritos.dart';
import 'package:cordeiropotiguar/controler/model/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Servicos.dart';

class DetalhesPokemon extends StatefulWidget {
  final Pokemon pokemon;

  DetalhesPokemon({this.pokemon});

  @override
  _DetalhesPokemonState createState() => _DetalhesPokemonState();
}

class _DetalhesPokemonState extends State<DetalhesPokemon> {
  Favoritos fav = new Favoritos();
  var text = "Favoritar / Desfavoritar";
  @override
  void initState() {
    _exibirlista();
    super.initState();
  }

  void _exibirlista() {
    fav.listfavorito().then((value) {
      value.map((e) {
        if (e == widget.pokemon.id) {
          setState(() {
            text = "Desfavoritar";
          });
        } else {
          setState(() {
            text = "Favoritar";
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          title: Text(
            widget.pokemon.name,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
            // height: MediaQuery.of(context).size.height / 2,
            //color: Colors.blue,
            padding: EdgeInsets.all(10.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  //color: Colors.red,
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                  title: Text(
                                "NOME: ${widget.pokemon.name}",
                              )),
                              ListTile(title: Text("ID: ${widget.pokemon.id}")),
                              ListTile(
                                title: Text(
                                    "ABILIDADE: ${widget.pokemon.abilities[0].ability.name}"),
                              ),
                              ListTile(
                                title: Text("ALTURA: ${widget.pokemon.height}"),
                              ),
                              ListTile(
                                title: Text("PESO: ${widget.pokemon.weight}"),
                              ),
                              ListTile(
                                title: Text(
                                    "ESPECIE: ${widget.pokemon.species.name}"),
                              ),
                              ListTile(
                                title: Text(
                                    "STAT: ${widget.pokemon.stats[0].stat.name}"),
                              ),
                              ListTile(
                                title: Text(
                                    "EFFORT: ${widget.pokemon.stats[0].effort}"),
                              ),
                              Container(
                                  color: Colors.yellow,
                                  child: TextButton(
                                    onPressed: () async {
                                      showSnackbar(context);
                                      await fav
                                          .addfavorito(widget.pokemon.id)
                                          .then((value) {
                                        setState(() {
                                          _exibirlista();
                                        });
                                      });
                                      ;
                                    },
                                    child: Text("$text"),
                                  )),
                            ],
                          ))
                    ],
                  ))
            ])));
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 7),
      content: Text("Favoritado / desfavoritado!"),
    ));
  }
}
