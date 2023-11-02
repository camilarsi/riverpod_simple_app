class DishOfDestiny {
  final int id;
  final String name;
  final String emoji;

  DishOfDestiny({
    required this.id,
    required this.name,
    required this.emoji,
  });

  factory DishOfDestiny.empty() {
    return DishOfDestiny(id: -1, name: "empty", emoji: "empty");
  }

  factory DishOfDestiny.fromJson(Map<String, dynamic> json) {
    return DishOfDestiny(
      id: json['id'],
      name: json['name'],
      emoji: json['emoji'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishOfDestiny &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          emoji == other.emoji;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ emoji.hashCode;
}
