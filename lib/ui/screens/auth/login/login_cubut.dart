import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';
import '../../../../domain/usecases/auth/logout_usecase.dart';
import '../../../../domain/usecases/auth/register_usecase.dart';
import 'login_cubit_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  LogInUseCase loginUseCase;
  LogOutUseCase logOutUseCase;
  RegisterUseCase registerUseCase;
  AuthCubit(this.loginUseCase, this.logOutUseCase, this.registerUseCase)
      : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final response = await loginUseCase.callLogin(email, password);
    response.fold(
      (failure) => emit(AuthFailure(failure)), // Emit failure state
      (user) => emit(AuthSuccess(user)), // Emit success state
    );
  }

  Future<void> register(String email, String password,String username) async {
    emit(AuthLoading());
    final response = await registerUseCase.callRegister(email, password,username);
    response.fold(
      (failure) => emit(AuthFailure(failure)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> logOut() async {
    await logOutUseCase.callLogOut();
    emit(AuthInitial());
  }
}
