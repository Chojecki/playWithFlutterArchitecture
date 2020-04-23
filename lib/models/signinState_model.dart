import 'package:freezed_annotation/freezed_annotation.dart';

part 'signinState_model.freezed.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required String emailAddress,
    @required String password,
    @required bool showErrorMessages,
    @required bool isSubmitting,
    @required bool isSuccess,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: '',
        password: '',
        showErrorMessages: false,
        isSubmitting: false,
        isSuccess: false,
      );
}
