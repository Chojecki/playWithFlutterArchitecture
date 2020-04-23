import 'package:flutter/material.dart';
import 'package:my_horses/domain/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getSignedInUser();
  Future<UserEntity> registerWithEmailAndPassword({
    @required String emailAddress,
    @required String password,
  });
  Future<UserEntity> signInWithEmailAndPassword({
    @required String emailAddress,
    @required String password,
  });

  Future<void> signOut();
}
