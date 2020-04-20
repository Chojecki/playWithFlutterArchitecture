class HorseEntity {
  final String id;
  final String name;
  final String note;
  final String imagePath;

  HorseEntity(this.name, this.id, this.note, this.imagePath);

  @override
  int get hashCode =>
      name.hashCode ^ note.hashCode ^ id.hashCode ^ imagePath.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorseEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          note == other.note &&
          id == other.id &&
          imagePath == other.imagePath;

  Map<String, Object> toJson() {
    return {'name': name, 'note': note, 'id': id, 'imagePath': imagePath};
  }

  @override
  String toString() {
    return 'TodoEntity{name: $name, note: $note, id: $id, imagePath $imagePath}';
  }

  static HorseEntity fromJson(Map<String, Object> json) {
    return HorseEntity(json['name'] as String, json['id'] as String,
        json['note'] as String, json['imagePath'] as String);
  }
}
