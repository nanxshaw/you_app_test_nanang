import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/bloc/user/user_bloc.dart';
import 'package:test/component/card_profile.dart';
import 'package:test/component/form_date.dart';
import 'package:test/component/form_input.dart';
import 'package:test/component/form_select_box.dart';
import 'package:intl/intl.dart';
import 'package:test/component/image_upload.dart';
import 'package:test/models/user_models.dart';

class AboutCard extends StatefulWidget {
  final UserModel userData;
  AboutCard({required this.userData});

  @override
  _AboutCardState createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController horoscopeController = TextEditingController();
  final TextEditingController zodiacController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  bool isEditing = false;
  int ages = 0;
  bool isCreate = true;
  File? _imageFile;
  String? imageBase64;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    UserModel userData = widget.userData;
    nameController.text =
        userData.data!.name != null ? userData.data!.name.toString() : '';
    horoscopeController.text = userData.data!.horoscope != null
        ? userData.data!.horoscope.toString()
        : '';
    zodiacController.text =
        userData.data!.zodiac != null ? userData.data!.zodiac.toString() : '';
    heightController.text =
        userData.data!.height != null ? userData.data!.height.toString() : '';
    weightController.text =
        userData.data!.weight != null ? userData.data!.weight.toString() : '';
    _loadPreferences();
    if (userData.data!.birthday != null) {
      DateTime parsedDate =
          DateFormat('dd-MM-yyyy').parse(userData.data!.birthday.toString());

      String bd = DateFormat('dd MM yyyy').format(parsedDate);
      birthdayController.text = userData.data!.birthday != null
        ? bd
        : '';
   
      DateTime birthDate =
          DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
      ages = calculateAge(birthDate);
    }
    setState(() {
      isCreate = userData.data!.name != null ? false : true;
    });
  }

  Future<void> _loadPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? gender = preferences.getString('gender');

    setState(() {
      _selectedGender = gender;
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      List<int> imageBytes = await XFile(image.path).readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        _imageFile = File(image.path);
        imageBase64 = base64Image.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEditing ? _buildForm() : _buildCard();
  }

  // horoscope
  String getHoroscope(String dates) {
    try {
      DateTime date = DateFormat('dd-MM-yyyy').parse(dates);
      int month = date.month;
      int day = date.day;

      if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
        return 'Aries';
      } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
        return 'Taurus';
      } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
        return 'Gemini';
      } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
        return 'Cancer';
      } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
        return 'Leo';
      } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
        return 'Virgo';
      } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
        return 'Libra';
      } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
        return 'Scorpio';
      } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
        return 'Sagittarius';
      } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
        return 'Capricorn';
      } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
        return 'Aquarius';
      } else {
        return 'Pisces';
      }
    } catch (e) {
      return "";
    }
  }

  // zodiac
  String getZodiac(String dates) {
    DateTime date = DateFormat('dd-MM-yyyy').parse(dates);
    int year = date.year;
    List<String> shioList = [
      'Monkey',
      'Rooster',
      'Dog',
      'Pig',
      'Rat',
      'Ox',
      'Tiger',
      'Rabbit',
      'Dragon',
      'Snake',
      'Horse',
      'Goat'
    ];
    int shioIndex = (year - 1900) % 12;
    return shioList[shioIndex];
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  // main
  Widget _buildCard() {
    UserModel userData = widget.userData;
    return CardProfile(
      color: Color(0xFF0E191F),
      onEditPressed: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            // ignore: unnecessary_null_comparison
            userData.data!.name != null
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Birthday:",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          Text(
                            userData.data!.birthday.toString() +
                                '(Age ' +
                                ages.toString() +
                                ')',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Horoscope:",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          Text(
                            userData.data!.horoscope.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Zodiac:",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          Text(
                            userData.data!.zodiac.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Height:",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          Text(
                            userData.data!.height.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Weight:",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          Text(
                            userData.data!.weight.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    "Add in your your to help others know you better",
                    style: TextStyle(color: Colors.white54),
                  ),
          ],
        ),
      ),
    );
  }

  //save data
  saveProfile() {
    String name = nameController.text;
    String birthday = birthdayController.text;
    int height = int.parse(heightController.text);
    int weight = int.parse(weightController.text);
    String horoscope = horoscopeController.text;
    String zodiac = zodiacController.text;
    DateTime parsedDate = DateFormat('dd MM yyyy').parse(birthday);
    String dateValue = DateFormat('dd-MM-yyyy').format(parsedDate);
    if (isCreate == true) {
      setState(() {
        isCreate = false;
      });
      BlocProvider.of<UserBloc>(context).add(CreateProfileEvent(
          name: name,
          birthday: dateValue,
          height: height,
          weight: weight,
          horoscope: horoscope,
          zodiac: zodiac,
          gender: _selectedGender,
          image: imageBase64));
    } else {
      BlocProvider.of<UserBloc>(context).add(UpdateProfileEvent(
          name: name,
          birthday: dateValue,
          height: height,
          weight: weight,
          horoscope: horoscope,
          zodiac: zodiac,
          gender: _selectedGender,
          image: imageBase64));
    }
    setState(() {
      isEditing = false;
    });
  }

  // form
  Widget _buildForm() {
    return CardProfile(
      color: Color(0xFF0E191F),
      isIcon: false,
      onEditPressed: () {
        setState(() {
          isEditing = false;
        });
      },
      child: Container(
        height: 550,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => saveProfile(),
                        child: Text(
                          "Save & Update",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff94783E),
                              fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ImageUpload(imageFile: _imageFile, pickImageCallback: _pickImage),
            FormInput(
              label: 'Display Name:',
              hintText: "Enter Name",
              controller: nameController,
            ),
            FormSelectBox(
              label: 'Gender:',
              hintText: "Select Gender",
              selectedValue: _selectedGender,
              onSelectChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              selectOptions: _genderOptions,
            ),
            FormDate(
              label: 'Birthday:',
              hintText: "DD MM YYYY",
              controller: birthdayController,
              onDateSelected: (date) {
                setState(() {
                  horoscopeController.text = getHoroscope(date.toString());
                  zodiacController.text = getZodiac(date.toString());
                });
              },
            ),
            FormInput(
                label: 'Horoscope:',
                hintText: "--",
                controller: horoscopeController,
                isReadOnly: true),
            FormInput(
                label: 'Zodiac:',
                hintText: "--",
                controller: zodiacController,
                isReadOnly: true),
            FormInput(
              label: 'Height:',
              hintText: "Add height",
              controller: heightController,
            ),
            FormInput(
              label: 'Weight:',
              hintText: "Add weight",
              controller: weightController,
            ),
          ],
        ),
      ),
    );
  }
}
