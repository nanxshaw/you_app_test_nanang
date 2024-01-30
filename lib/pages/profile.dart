import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/user/user_bloc.dart';
import 'package:test/component/modal_popup.dart';
import 'package:test/models/user_models.dart';
import 'package:test/pages/profile/about_card.dart';
import 'package:test/pages/profile/interest_card.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileSate createState() => _ProfileSate();
}

class _ProfileSate extends State<Profile> {
  late String? gender = '';
  late String? image64 = '';

  @override
  void initState() {
    super.initState();
    // getData();
    // request data user
    context.read<UserBloc>().add(GetProfileEvent());
  }

  // Future<void> getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final _gender = prefs.getString('gender');
  //   final _image64 = prefs.getString('image64');
  //   if (_gender != null && _image64 != null) {
  //     setState(() {
  //       gender = _gender;
  //       image64 = _image64;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            final user = state.user.data;
            final interest = state.user.data!.interests;
            return Stack(
              children: [
                // background
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Color(0xff0e191f),
                ),

                // content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // header
                      AppBar(
                        centerTitle: true,
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
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          user!.username.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // content
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfileCard(
                              userData: state.user,
                              gender:  state.gender,
                              image64: state.image,
                            ),
                            SizedBox(height: 10),
                            AboutCard(userData: state.user),
                            SizedBox(height: 10),
                            InterestCard(interests: interest)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is ProfileFailure) {
            return Center(
              child: Text('Failed to load profile. ${state.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

//function
void _showModalPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ModalPopup(
        title: 'Notice',
        subtitle: 'Apakah anda ingin keluar?',
        onExitPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        onCancelPressed: () {
          Navigator.pop(context);
        },
      );
    },
  );
}

// card
class ProfileCard extends StatelessWidget {
  final UserModel userData;
  final String? gender;
  final String? image64;

  ProfileCard({required this.userData, this.gender, this.image64});

  IconData getZodiacIcon(String zodiacSign) {
    switch (zodiacSign) {
      case 'Aries':
        return Icons.adjust;
      case 'Taurus':
        return Icons.nature;
      case 'Gemini':
        return Icons.dialpad;
      case 'Cancer':
        return Icons.beach_access;
      case 'Leo':
        return Icons.star;
      case 'Virgo':
        return Icons.build;
      case 'Libra':
        return Icons.attach_money;
      case 'Scorpio':
        return Icons.brightness_3;
      case 'Sagittarius':
        return Icons.explore;
      case 'Capricorn':
        return Icons.location_city;
      case 'Aquarius':
        return Icons.invert_colors;
      case 'Pisces':
        return Icons.pool;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    try {
      bytes = base64Decode(image64.toString());
    } catch (e) {
      print('Error decoding base64 image: $e');
      bytes = null;
    }
    IconData horoscopeIcon = getZodiacIcon(userData.data!.horoscope.toString());
    return Card(
      elevation: 4.0,
      color: Color(0xFF162329),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            image64 != null
                ? Image.memory(
                    bytes!,
                    fit: BoxFit.cover,
                    height: 190,
                    width: double.infinity,
                  )
                : Container(
                    height: 190,
                  ),
            Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.data!.username.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    gender != null
                        ? Text(
                            gender.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    userData.data!.horoscope != null &&
                            userData.data!.zodiac != null
                        ? Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration: BoxDecoration(
                                    color: Color(0xFF162329),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white54)),
                                child: Row(
                                  children: [
                                    Icon(
                                      horoscopeIcon,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      userData.data!.horoscope.toString(),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration: BoxDecoration(
                                    color: Color(0xFF162329),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white54)),
                                child: Text(
                                  userData.data!.zodiac.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container()
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
