import 'package:booking/ui/widgets/failures.dart';

import '../../../../domain/model/user_dm.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserDM user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final Failures failures;

  AuthFailure(this.failures);
}
