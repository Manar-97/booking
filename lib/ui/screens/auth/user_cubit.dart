import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';

class UserState {
  final bool isLoading;
  final String errorMessage;

  UserState({this.isLoading = false, this.errorMessage = ''});
}
@injectable
class UserCubit extends Cubit<UserState> {
  final LogOutUseCase logoutUseCase;

  UserCubit(this.logoutUseCase) : super(UserState());

  Future<void> logout() async {
    emit(UserState(isLoading: true));
    final result = await logoutUseCase.callLogOut();

    result.fold(
      (failure) {
        emit(UserState(isLoading: false, errorMessage: failure.errorMessage));
      },
      (_) {
        emit(UserState(isLoading: false));
        // Handle successful logout (e.g., navigate to login screen)
      },
    );
  }
}
