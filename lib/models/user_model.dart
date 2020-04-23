import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_horses/domain/user_entity.dart';

part 'user_model.freezed.dart';

@freezed
abstract class User with _$User implements UserEntity {
  const factory User(
      {@required String id, String displayName, String photoUrl}) = _User;
}
