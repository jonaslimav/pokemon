import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'Favoritos.dart';
import 'model/pokemon.dart';

Future<List<Pokemon>> receberPokemons(tipo) async {
  List<Pokemon> lista = new List();
  var i = 1;
  for (i; i <= 20; i++) {
    var url = Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$i");
    var response = await http.get(url, headers: {"Acept": "application/json"});

    var jsonResponse = convert.jsonDecode(response.body);
    if (tipo == "todos") {
      lista.add(Pokemon.fromJson(jsonResponse));
    } else if (Pokemon.fromJson(jsonResponse).types[0].type.name == tipo) {
      lista.add(Pokemon.fromJson(jsonResponse));
    }
  }

  return lista;
}

Future<List<Pokemon>> receberPokemonsF() async {
  Favoritos fav = new Favoritos();
  List<int> listf = new List();
  listf = await fav.listfavorito();
  List<Pokemon> lista = new List();
  var i = 1;
  for (i; i < listf.length; i++) {
    var url = Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/${listf[i]}");
    var response = await http.get(url, headers: {"Acept": "application/json"});

    var jsonResponse = convert.jsonDecode(response.body);
    lista.add(Pokemon.fromJson(jsonResponse));
  }
  return lista;
}

Future<List<Pokemon>> receberPokemonPesquisa(nome) async {
  print(nome);
  List<Pokemon> lista = new List();
  var url = Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/${nome}");
  var response = await http.get(url, headers: {"Acept": "application/json"});

  var jsonResponse = convert.jsonDecode(response.body);
  print(Pokemon.fromJson(jsonResponse));
  lista.add(Pokemon.fromJson(jsonResponse));
  if (lista == null) {
    Pokemon pk = new Pokemon();
    pk.name = "sem Respostas";
    pk.id = 0;
    lista.add(pk);
  }
  return lista;
}
