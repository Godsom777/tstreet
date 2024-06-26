import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  const CustomCircleAvatar({Key? key, required this.onTap, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}