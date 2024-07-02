class SuperHero {
  final String id;
  final String name;
  final String gender;
  final String img;

  const SuperHero({
    required this.id,
    required this.name,
    required this.gender,
    required this.img,
  });

  // Constructor para crear una instancia desde un JSON
  SuperHero.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        gender = json['appearance']?['gender'] ?? 'Unknown', // Maneja la clave faltante
        img = json['image']['url'];

  // Método para convertir una instancia a un JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'img': img,
      };
}

// Clase para representar un héroe favorito
class FavoriteHero {
  final String id;
  final String name;

  // Constructor para crear una instancia desde un Map
  FavoriteHero.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
