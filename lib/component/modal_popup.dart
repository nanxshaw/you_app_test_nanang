import 'package:flutter/material.dart';

class ModalPopup extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onExitPressed;
  final Function onCancelPressed;

  ModalPopup({
    required this.title,
    required this.subtitle,
    required this.onExitPressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Panggil fungsi onExitPressed ketika tombol "Exit" ditekan
              onExitPressed();
            },
            child: Text('Exit'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Panggil fungsi onCancelPressed ketika tombol "Cancel" ditekan
              onCancelPressed();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}