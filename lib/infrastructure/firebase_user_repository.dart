import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_horses/domain/user_entity.dart';
import 'package:my_horses/domain/user_repository.dart';
import 'package:my_horses/infrastructure/firebase_user_mapper.dart';

@lazySingleton
@RegisterAs(UserRepository, env: 'dev')
class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _auth;
  final FirebaseUserMapper _userMapper;

  const FirebaseUserRepository(this._auth, this._userMapper);

  @override
  Future<UserEntity> getSignedInUser() async {
    try {
      final firebaseUser = await _auth.currentUser();
      return _userMapper.toDomain(firebaseUser);
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  @override
  Future<UserEntity> registerWithEmailAndPassword(
      {String emailAddress, String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      return _userMapper.toDomain(user.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(
      {String emailAddress, String password}) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: emailAddress, password: password);
    return _userMapper.toDomain(user.user);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
