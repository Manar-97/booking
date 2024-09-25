import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../ui/widgets/failures.dart';
import '../../model/user_dm.dart';
import '../../repositories/auth/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<Either<Failures,UserDM>> callRegister(String email, String password, String username) async {
    return await authRepository.register(email, password,username);
  }
}