import 'package:injectable/injectable.dart';
import 'package:my_horses/domain/user_repository.dart';
import 'package:my_horses/models/userState_model.dart';
import 'package:state_notifier/state_notifier.dart';

@injectable
class AuthStateModel extends StateNotifier<UserState> {
  final UserRepository userRepo;
  AuthStateModel({this.userRepo}) : super(UserState.initial());

  void getSignedInUser() async {
    final user = await userRepo.getSignedInUser();
    if (user != null) {
      state = UserState.authenticated(user);
    } else {
      state = UserState.unauthenticated();
    }
  }

  void signOut() async {
    await userRepo.signOut();
    state = UserState.unauthenticated();
  }
}
