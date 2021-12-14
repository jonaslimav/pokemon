// import 'package:cordeiropotiguar/controler/model/pokemon.dart';
// import 'package:mobx/mobx.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// part 'MostrarTodos.g.dart';

// class MostrarTodos = MostrarTodosBase with _$MostrarTodos;

// abstract class MostrarTodosBase with Store {
//   @observable
//   List<Pokemon> listP;

//   @action
//   filtrarPokemonsTipo(tipo) async {
//     List<Pokemon> lista;
//     for (int i = 1; i <= 20; i++) {
//       var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$i', {'q': '{http}'});
//       var response = await http.get(url);
//       var jsonResponse =
//           convert.jsonDecode(response.body) as Map<String, dynamic>;
//       if (Pokemon.fromJson(jsonResponse).types[0].type.name == tipo) {
//         lista.add(Pokemon.fromJson(jsonResponse));
//       }
//     }

//     listP = lista;
//   }

//   @action
//   receberPokemons() async {
//     List<Pokemon> lista = new List();
//     var i = 1;
//     for (i; i <= 20; i++) {
//       var url = Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$i");
//       var response =
//           await http.get(url, headers: {"Acept": "application/json"});

//       var jsonResponse = convert.jsonDecode(response.body);
//       lista.add(Pokemon.fromJson(jsonResponse));
//     }
//     listP = lista;
//   }
// }
