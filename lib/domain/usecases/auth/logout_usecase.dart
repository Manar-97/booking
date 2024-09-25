import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../ui/widgets/failures.dart';
import '../../repositories/auth/auth_repository.dart';

@injectable
class LogOutUseCase {
  final AuthRepository authRepository;

  LogOutUseCase(this.authRepository);

  Future<Either<Failures, void>> callLogOut() async {
    return await authRepository.logOut();
  }
}
