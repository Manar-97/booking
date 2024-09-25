import 'package:booking/ui/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/di.dart';
import '../../../utils/dialog_utils.dart';
import '../../../widgets/cust_text_field.dart';
import '../../../widgets/failures.dart';
import '../../../widgets/validators.dart';
import '../login/login_cubit_state.dart';
import '../login/login_cubut.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  AuthCubit cubit = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Register"),
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
                      context, LoginScreen.routeName); // Show success state
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .14,
                      ),
                      const Text(
                        "Dollagy Travel",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      CustomTextField(
                        hint: 'enter your name',
                        label: 'User Name',
                        type: TextInputType.text,
                        validation: AppValidators.validateUsername,
                        controller: username,
                      ),
                      CustomTextField(
                        hint: 'enter your email',
                        label: 'Email',
                        type: TextInputType.text,
                        validation: AppValidators.validateEmail,
                        controller: email,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        hint: 'enter your password',
                        label: 'Password',
                        type: TextInputType.text,
                        isObscured: true,
                        validation: AppValidators.validatePassword,
                        controller: password,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            context.read<AuthCubit>().register(
                                email.text, password.text, username.text);
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: Row(
                              children: [
                                Text(
                                  "Create account",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
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
                            "I Already Have An Account! ",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
