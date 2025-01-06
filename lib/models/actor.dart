import 'dart:convert';

// Aquest codi defineix el model `TopRatedActor`, que s'utilitza per representar 
// un actor destacat amb les dades següents: identificador únic (id), nom, imatge de perfil, 
// nivell de popularitat i una llista de produccions conegudes. També inclou mètodes per crear 
// un objecte a partir de mapes o cadenes JSON, cosa que facilita la conversió de dades 
// provinents d'una API de manera senzilla i eficient.

class Actor {
  int id;
  String name;
  String profile_path;
  String biography;
  String birthday;
  String place_of_birth;
  Actor({
    required this.id,
    required this.name,
    required this.biography,
    required this.profile_path,
    required this.birthday,
    required this.place_of_birth,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      biography: map['biography'] ?? '',
      profile_path: map['profile_path'] ?? '',
      birthday: map['birthday'] ?? '',
      place_of_birth: map['place_of_birth'] ?? '',
    );
  }
  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
