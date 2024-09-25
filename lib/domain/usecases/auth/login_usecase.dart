import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../ui/widgets/failures.dart';
import '../../model/user_dm.dart';
import '../../repositories/auth/auth_repository.dart';

@injectable
class LogInUseCase {
  final AuthRepository authRepository;

  LogInUseCase(this.authRepository);

  Future<Either<Failures,UserDM>> callLogin(String email, String password) async {
    return await authRepository.login(email, password);
  }
}