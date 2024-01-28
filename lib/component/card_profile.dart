import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CardProfile extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onEditPressed;
  final bool isIcon;

  CardProfile({
    required this.color,
    required this.child,
    required this.onEditPressed,
    this.isIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: color,
      child: Stack(
        children: [
          isIcon ? Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              icon: Icon(Iconsax.edit_2),
              onPressed: onEditPressed,
            ),
          )
          :
          Container(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
