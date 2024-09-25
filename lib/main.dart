import 'package:booking/ui/home.dart';
import 'package:booking/ui/screens/auth/login/login_cubut.dart';
import 'package:booking/ui/screens/auth/login/login_screen.dart';
import 'package:booking/ui/screens/auth/register/register_screen.dart';
import 'package:booking/ui/screens/auth/user_cubit.dart';
import 'package:booking/ui/screens/category/hotels/hotel_cubit.dart';
import 'package:booking/ui/screens/category/hotels/hotels.dart';
import 'package:booking/ui/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => getIt<UserCubit>()),
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<HotelCubit>(create: (context) => getIt<HotelCubit>()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Splash.routeName: (_) => const Splash(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          RegisterScreen.routeName: (_) => const RegisterScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          HotelsScreen.routeName: (_) => const HotelsScreen()
        },
        initialRoute: HotelsScreen.routeName,
      ),
    );
  }
}
