import 'package:booking/ui/widgets/failures.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../domain/model/user_dm.dart';
import '../../../domain/repositories/auth/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  InternetConnectionChecker internetConnectionChecker;
  AuthRepositoryImpl(this.firebaseAuth, this.internetConnectionChecker);

  @override
  Future<Either<Failures, UserDM>> login(String email, String password) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return Right(UserDM(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
        ));
      } catch (e) {
        return Left(Failures(e.toString()));
      }
    } else {
      return Left(ConnectionFailures());
    }
  }

  @override
  Future<Either<Failures, UserDM>> register(
      String email, String password, String username) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return Right(UserDM(
            id: userCredential.user!.uid, email: userCredential.user!.email!));
      } catch (e) {
        return Left(Failures(e.toString()));
      }
    } else {
      return Left(ConnectionFailures());
    }
  }

  @override
  Future<Either<Failures, UserDM>> getCurrentUser() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        User? user = firebaseAuth.currentUser;
        if (user != null) {
          return Right(UserDM(id: user.uid, email: user.email!));
        } else {
          return Left(UnAuthenticatedFailures());
        }
      } catch (e) {
        return Left(Failures(e.toString()));
      }
    } else {
      return Left(ConnectionFailures());
    }
  }

  @override
  Future<Either<Failures, void>> logOut() async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        return Right(await firebaseAuth.signOut());
      } else {
        return Left(ConnectionFailures());
      }
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}
