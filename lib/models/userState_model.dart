import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_horses/models/user_model.dart';

part 'userState_model.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.authenticated(User user) = Authenticated;
  const factory UserState.unauthenticated() = Unauthenticated;
}
