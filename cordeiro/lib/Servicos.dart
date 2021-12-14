import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'Pages/LoginPage.dart';
import 'package:crypto/crypto.dart';

import 'controler/MostrarTodos.dart';
import 'controler/model/Favorito.dart';
import 'controler/model/pokemon.dart';
import 'controler/Favoritos.dart';

final LocalStorage storage = new LocalStorage('poke_app');
final LocalStorage favoritos = new LocalStorage('fav_poke');
Favoritos fav = new Favoritos();

void limparStorage() {
  storage.clear();
}

void inserirToken(email, senha) {
  final token = gerarToken(email, senha);
  storage.setItem('token', token);
}

String mostrarToken() {
  return storage.getItem('token');
}

String gerarToken(email, senha) {
  return email + senha + "abc";
}

Future<bool> consultarToken() async {
  return await storage.getItem('token') != null;
}

void favoritarPokemon(id) async {
  fav.addfavorito(id).then((value) => print(value));
}

void desfavoritarPokemon(id) async {
  fav.excluirfavorito(id);
}
