import 'package:flutter/material.dart';
import 'package:test/component/card_profile.dart';

class InterestCard extends StatelessWidget {
  final List<String> interests;

  InterestCard({required this.interests});

  @override
  Widget build(BuildContext context) {
    return CardProfile(
      color: Color(0xFF0E191F),
      onEditPressed: () => {Navigator.pushNamed(context, '/forminterest')},
      child: Container(
        height: 120,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interests',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text("Add in your interest to find a better match",
                style: TextStyle(color: Colors.white54)),
            // Column(
            //   children: interests.map((interest) {
            //     return Text(interest, style: TextStyle(color: Colors.white54));
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
