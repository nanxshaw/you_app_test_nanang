import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/auth/auth_bloc.dart';
import 'package:test/component/button.dart';
import 'package:test/component/text_input.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamed(context, '/profile');
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Stack(
            children: [
              // background
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF09141A),
                      Color(0xFF0D1C22),
                      Color(0xFF1F4247)
                    ],
                  ),
                ),
              ),

              // Form Login
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 18),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextInput(
                        controller: emailController,
                        hintText: 'Enter E-mail',
                      ),
                      SizedBox(height: 10),
                      TextInput(
                        controller: usernameController,
                        hintText: 'Enter Username',
                      ),
                      SizedBox(height: 10),
                      TextInput(
                        controller: passwordController,
                        hintText: 'Enter Password',
                        isPassword: true,
                        isIconPassword: true,
                      ),
                      SizedBox(height: 20),
                      Button(
                        label: "Login",
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            email: emailController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                          ));
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.all(0)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Register here',
                                style: TextStyle(
                                  color: Color(0xFF93773E),
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF93773E),
                                  height: 0,
                                ),
                              ),
                            )
                          ]),
                    ],
                  )),
            ],
          )),
    );
  }
}
