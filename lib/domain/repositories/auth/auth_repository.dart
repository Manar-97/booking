import 'package:either_dart/either.dart';
import '../../../ui/widgets/failures.dart';
import '../../model/user_dm.dart';

abstract class AuthRepository{
  Future<Either<Failures,UserDM>> login(String email ,String password);

  Future<Either<Failures,UserDM>> register(String email ,String password,String username);

  Future<Either<Failures,void>> logOut();

  Future<Either<Failures,UserDM>> getCurrentUser();
}