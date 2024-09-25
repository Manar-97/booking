import 'package:booking/ui/home.dart';
import 'package:booking/ui/screens/auth/login/login_cubit_state.dart';
import 'package:booking/ui/widgets/cust_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/di.dart';
import '../../../utils/dialog_utils.dart';
import '../../../widgets/failures.dart';
import '../../../widgets/validators.dart';
import '../register/register_screen.dart';
import 'login_cubut.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  AuthCubit cubit = getIt();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: BlocListener<AuthCubit, AuthState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is AuthLoading) {
                showLoading(context); // Show loading state
              } else if (state is AuthFailure) {
                hideLoading(context);
                Failures failures = (state).failures;
                showMessage(context,
                    body: failures.errorMessage,
                    posButtonTitle: "Ok"); // Show error state
              } else if (state is AuthSuccess) {
                Navigator.pushNamed(
                    context, HomeScreen.routeName); // Show success state
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back To",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Dollagy Travel !",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    hint: 'enter your name',
                    label: 'User name',
                    type: TextInputType.emailAddress,
                    validation: AppValidators.validateEmail,
                    controller: email,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    hint: 'enter your password',
                    label: 'Password',
                    isObscured: true,
                    type: TextInputType.text,
                    validation: AppValidators.validatePassword,
                    controller: password,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .login(email.text, password.text);
                        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't Have An Account?  ",
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text(
                          "Create account",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
