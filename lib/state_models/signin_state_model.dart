import 'package:injectable/injectable.dart';
import 'package:my_horses/domain/user_repository.dart';
import 'package:my_horses/models/signinState_model.dart';
import 'package:state_notifier/state_notifier.dart';

@injectable
class SignInStateModel extends StateNotifier<SignInFormState> {
  final UserRepository userRepo;
  SignInStateModel({this.userRepo}) : super(SignInFormState.initial());

  void emailChanged(String emailAddress) {
    final newState = this.state.copyWith(emailAddress: emailAddress);
    state = newState;
  }

  void passwordChanged(String password) {
    final newState = this.state.copyWith(password: password);
    state = newState;
  }

  void registerWithEmailAndPasswordPressed() async {
    state = this.state.copyWith(isSubmitting: true);
    final user = await userRepo.registerWithEmailAndPassword(
        emailAddress: state.emailAddress, password: state.password);
    if (user != null) {
      state = this.state.copyWith(isSubmitting: false, isSuccess: true);
    } else {
      state = this.state.copyWith(isSubmitting: false, showErrorMessages: true);
    }
  }

  void signInWithEmailAndPasswordPressed() async {
    state = this.state.copyWith(isSubmitting: true);
    final user = await userRepo.signInWithEmailAndPassword(
        emailAddress: state.emailAddress, password: state.password);
    if (user != null) {
      state = this.state.copyWith(isSubmitting: false, isSuccess: true);
    } else {
      state = this.state.copyWith(isSubmitting: false, showErrorMessages: true);
    }
  }
}
