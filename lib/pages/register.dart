import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/auth/auth_bloc.dart';
import 'package:test/component/button.dart';
import 'package:test/component/text_input.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushNamed(context, '/login');
          } else if (state is RegisterFailure) {
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

            // header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leadingWidth: 100,
                leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                      'Register',
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
                    hintText: 'Create Username',
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    controller: passwordController,
                    hintText: 'Create Password',
                    isPassword: true,
                    isIconPassword: true,
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    controller: passwordConfirmController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                    isIconPassword: true,
                  ),
                  SizedBox(height: 20),
                  Button(
                    label: "Register",
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        password_confirm: passwordConfirmController.text,
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
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.all(0)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login here',
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
