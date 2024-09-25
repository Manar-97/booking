// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;

import '../db/ds/hotels/remote_ds.dart' as _i6;
import '../db/repositories/auth/auth_repository_impl.dart' as _i8;
import '../db/repositories/hotels/hotel_repository_impl.dart' as _i10;
import '../domain/repositories/auth/auth_repository.dart' as _i7;
import '../domain/repositories/hotels/hotel_repository.dart' as _i9;
import '../domain/usecases/auth/login_usecase.dart' as _i13;
import '../domain/usecases/auth/logout_usecase.dart' as _i14;
import '../domain/usecases/auth/register_usecase.dart' as _i15;
import '../domain/usecases/hotels/hotels_usecase.dart' as _i11;
import '../ui/screens/auth/login/login_cubut.dart' as _i17;
import '../ui/screens/auth/user_cubit.dart' as _i16;
import '../ui/screens/category/hotels/hotel_cubit.dart' as _i12;
import 'modules/firebase_modul.dart' as _i18;
import 'modules/network_modul.dart' as _i19;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final fireBaseModule = _$FireBaseModule();
    final networkModules = _$NetworkModules();
    gh.singleton<_i3.FirebaseAuth>(() => registerModule.getFirebaseAuth());
    gh.singleton<_i4.FirebaseFirestore>(
        () => fireBaseModule.getFirebaseFirestore());
    gh.singleton<_i5.InternetConnectionChecker>(
        () => networkModules.getInternetConnectionChecker());
    gh.factory<_i6.HotelRemoteDataSource>(
        () => _i6.HotelRemoteDataSourceImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i7.AuthRepository>(() => _i8.AuthRepositoryImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i5.InternetConnectionChecker>(),
        ));
    gh.factory<_i9.HotelRepository>(() => _i10.HotelRepositoryImpl(
          gh<_i6.HotelRemoteDataSource>(),
          gh<_i5.InternetConnectionChecker>(),
        ));
    gh.factory<_i11.GetHotelsUseCase>(
        () => _i11.GetHotelsUseCase(gh<_i9.HotelRepository>()));
    gh.factory<_i12.HotelCubit>(
        () => _i12.HotelCubit(gh<_i11.GetHotelsUseCase>()));
    gh.factory<_i13.LogInUseCase>(
        () => _i13.LogInUseCase(gh<_i7.AuthRepository>()));
    gh.factory<_i14.LogOutUseCase>(
        () => _i14.LogOutUseCase(gh<_i7.AuthRepository>()));
    gh.factory<_i15.RegisterUseCase>(
        () => _i15.RegisterUseCase(gh<_i7.AuthRepository>()));
    gh.factory<_i16.UserCubit>(() => _i16.UserCubit(gh<_i14.LogOutUseCase>()));
    gh.factory<_i17.AuthCubit>(() => _i17.AuthCubit(
          gh<_i13.LogInUseCase>(),
          gh<_i14.LogOutUseCase>(),
          gh<_i15.RegisterUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}

class _$FireBaseModule extends _i18.FireBaseModule {}

class _$NetworkModules extends _i19.NetworkModules {}
