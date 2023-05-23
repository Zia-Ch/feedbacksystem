import 'package:feedbacksystem/apis/auth_api.dart';
import 'package:feedbacksystem/helper/auth/email_password_sign_in_validators.dart';
import 'package:feedbacksystem/helper/enums/auth_from_type_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue>((ref) {
  return AuthController(
    authApi: ref.watch(authApiProvider),
    //userApi: ref.watch(userApiProvider),
  );
});

class AuthController extends StateNotifier<AsyncValue> {
  final AuthApi _authApi;
  final emailPasswordValidator = EmailAndPasswordValidators();

  AuthController({
    required AuthApi authApi,
  })  : _authApi = authApi,
        super(
          const AsyncData(null),
        );

  Future<bool> submitForm({
    required String email,
    required String password,
    required AuthFormType formType,
    String confirmPassword = '',
  }) async {
    state = const AsyncValue.loading();
    String? emailErrorText = emailPasswordValidator.emailErrorText(email);
    String? passwordErrorText =
        emailPasswordValidator.passwordErrorText(password, formType);
    String? passwordMatchedErrorText = emailPasswordValidator.passwordmatched(
      password,
      confirmPassword,
    );
    if (emailErrorText != null) {
      state = AsyncValue.error(emailErrorText, StackTrace.current);
    } else if (passwordErrorText != null) {
      state = AsyncValue.error(passwordErrorText, StackTrace.current);
    } else if (formType == AuthFormType.signUp &&
        passwordMatchedErrorText != null) {
      state = AsyncValue.error(passwordMatchedErrorText, StackTrace.current);
    } else {
      await _authenticate(
        email: email,
        password: password,
        formType: formType,
        confirmPassword: confirmPassword,
      );
    }

    return state.hasError == false;
  }

  Future<void> _authenticate({
    required String email,
    required String password,
    required AuthFormType formType,
    String? confirmPassword,
  }) async {
    switch (formType) {
      case AuthFormType.signUp:
        final res = await _authApi.signup(
          email: email,
          password: password,
        );
        res.fold(
          (l) => state = AsyncValue.error(
            l.message,
            l.stackTrace,
          ),
          (r) => state = AsyncValue.data(r),
        );
        break;

      case AuthFormType.signIn:
        final res = await _authApi.signin(email: email, password: password);
        res.fold(
          (l) => state = AsyncValue.error(
            l.message,
            l.stackTrace,
          ),
          (r) => state = AsyncValue.data(r),
        );
        break;

      // ! case AuthFormType.signOut:
    }
  }

  Future<model.User?> get currentUser => _authApi.currentUserAccount();
}
