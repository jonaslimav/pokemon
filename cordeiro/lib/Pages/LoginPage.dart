import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Servicos.dart';
import 'HomePage.dart';

class LoginPage extends StatelessWidget {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tam = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: tam.height / 8,
          title: Image.asset('Images/imghome.png',
              height: tam.height / 8, width: tam.width),
          backgroundColor: Colors.white,
        ),
        body: ListView(children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("Comece a coletar pokémons!",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white,
                  width: tam.width / 1.5,
                  height: tam.height / 4,
                  child: _body(context),
                ),
                SizedBox(
                  height: tam.height / 10,
                ),
                Image.asset('Images/imglog2.jpeg',
                    height: tam.height / 2, width: tam.width),
              ],
            ),
          )
        ]));
  }

  _body(BuildContext context) {
    var tam = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Container(
            width: tam.width / 2,
            child: Column(
              children: <Widget>[
                textFormFieldLogin(),
                SizedBox(height: 10),
                textFormFieldSenha(),
                SizedBox(height: 10),
                containerButton(context)
              ],
            )));
  }

  TextFormField textFormFieldLogin() {
    return TextFormField(
        controller: _tLogin,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "E-MAIL",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe o email"));
  }

  TextFormField textFormFieldSenha() {
    return TextFormField(
        controller: _tSenha,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "SENHA",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe a senha"));
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text("LOGUIN",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          _onClickLogin(context);
        },
      ),
    );
  }

  _onClickLogin(BuildContext context) async {
    final login = _tLogin.text;
    final senha = _tSenha.text;
    print("Login: $login , Senha: $senha ");

    if (login.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: Text("Login e/ou Senha inválido(s)"),
              actions: <Widget>[
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        },
      );
    } else {
      inserirToken(login, senha);
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
      print("logado");
    }
  }
}
