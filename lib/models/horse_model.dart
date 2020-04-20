import 'package:flutter/material.dart';
import 'package:my_horses/domain/horse_entity.dart';
import 'package:uuid/uuid.dart';

class Horse {
  final String name;
  final String id;
  final String note;
  final String image;

  Horse(this.name, {this.note = '', String id, this.image})
      : id = id ?? Uuid().v4();

  @override
  int get hashCode =>
      name.hashCode ^ note.hashCode ^ id.hashCode ^ image.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Horse &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          note == other.note &&
          image == other.image &&
          id == other.id;

  @override
  String toString() {
    return 'Horse{name: $name, note: $note, id: $id, image: $image}';
  }

  HorseEntity toEntity() {
    return HorseEntity(name, id, note, image);
  }

  static Horse fromEntity(HorseEntity entity) {
    return Horse(entity.name,
        note: entity.note, id: entity.id, image: entity.imagePath);
  }

  Horse copy({String name, String id, String note, Image image}) {
    return Horse(name ?? this.name,
        note: note ?? this.note, id: id ?? this.id, image: image ?? this.image);
  }
}
