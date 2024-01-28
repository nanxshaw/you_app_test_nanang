import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/bloc/user/user_bloc.dart';
import 'package:test/component/card_profile.dart';
import 'package:test/component/form_date.dart';
import 'package:test/component/form_input.dart';
import 'package:test/component/form_select_box.dart';
import 'package:intl/intl.dart';
import 'package:test/component/image_upload.dart';

class AboutCard extends StatefulWidget {
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
  bool isEditing = true;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image != null ? File(image.path) : null;
    });
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

  // main
  Widget _buildCard() {
    return CardProfile(
      color: Color(0xFF0E191F),
      onEditPressed: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        height: 120,
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
            Text(
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
    String name = nameController.text.toString();
    String birthday = birthdayController.text.toString();
    int height = int.parse(heightController.text);
    int weight = int.parse(weightController.text);
    BlocProvider.of<UserBloc>(context).add(UpdateProfileEvent(
      name: name,
      birthday: birthday,
      height: height,
      weight: weight,
    ));
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
