import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/auth/auth_bloc.dart';

class FormInterest extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

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

              // Form interest
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 18),
                        child: Text(
                          'Tell everyone about yourself',
                          style: TextStyle(
                            color: Color(0xFF93773E),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            decorationColor: Color(0xFF93773E),
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 18),
                        child: Text(
                          'What interest you?',
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
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'Enter Tag',
                                hintText: 'Type your tag here',
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                String enteredTag = _controller.text;
                                // Process the entered tag as needed
                                print('Entered Tag: $enteredTag');
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
