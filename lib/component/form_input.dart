import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final String hintText;

  FormInput({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.hintText = ""
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 38.0,
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: keyboardType,
                textAlign: TextAlign.right,
                readOnly: isReadOnly,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 13.0, color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Color(0xff4c5559)),
                  alignLabelWithHint: true,
                  fillColor: Color(0xff1a252a),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xff4c5559))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
