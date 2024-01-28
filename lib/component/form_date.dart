import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormDate extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  FormDate({
    required this.label,
    required this.controller,
    required this.onDateSelected,
    this.hintText = ""
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    // ignore: unnecessary_null_comparison
    if (picked != null) {
      onDateSelected(picked);
      controller.text = DateFormat('dd MM yyyy').format(picked);
    }
  }

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
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controller,
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
                  readOnly: true,
                  decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                    fillColor: Color(0xff1a252a),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xff4c5559),
                      ),
                    ),
                    alignLabelWithHint: true,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Color(0xff4c5559)),
                  ),
                  onTap: () async {
                    await _selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal tidak boleh kosong';
                    }
                    return null;
                  },
                )),
          ),
        ],
      ),
    );
  }
}
