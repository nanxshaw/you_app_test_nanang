import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FormSelectBox extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final void Function(String?)? onSelectChanged;
  final List<String>? selectOptions;
  final String hintText;

  FormSelectBox({
    required this.label,
    this.selectedValue,
    this.onSelectChanged,
    this.selectOptions,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1.0,
                    color: Color(0xff4c5559),
                  ),
                  color: Color(0xff1a252a),
                ),
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: selectOptions!.map((String select) {
                    return DropdownMenuItem<String>(
                      value: select,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          select,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onSelectChanged,
                  dropdownColor: Color(0xff4c5559),
                  style: TextStyle(color: Colors.white),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Iconsax.arrow_down_1,
                    color: Colors.white,
                  ),
                  isExpanded: true,
                  hint: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      selectedValue ?? hintText,
                      style: TextStyle(color: Color(0xff4c5559)),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
