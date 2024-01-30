import 'package:flutter/material.dart';
import 'package:test/component/card_profile.dart';

class InterestCard extends StatelessWidget {
  final List<String>? interests;

  InterestCard({required this.interests});

  @override
  Widget build(BuildContext context) {
    return CardProfile(
      color: Color(0xFF0E191F),
      onEditPressed: () => {
        Navigator.pushNamed(
          context,
          '/forminterest',
          arguments: interests,
        )
      },
      child: Container(
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
            interests!.length > 0 
                ? Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: interests!.map((interest) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                        decoration: BoxDecoration(
                          color: Color(0xff1a252a),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          interest,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  )
                : Text("Add in your interest to find a better match",
                    style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
