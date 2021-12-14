class Favorito {
  int idp;

  int id;
  String token;

  Favorito();

  Map<String, dynamic> toMap() {
    // ignore: unused_local_variable
    var map = <String, dynamic>{'id': id, 'idp': idp, 'token': token};
    return map;
  }

  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idp = map['idp'];
    token = map['token'];
  }
}
