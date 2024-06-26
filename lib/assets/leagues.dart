import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// CustomCircleAvatar is a custom widget that represents a circular avatar.
class CustomCircleAvatar extends StatelessWidget {
  final String imagePath; // The path to the image file.
  final VoidCallback onTap; // A callback function to be called when the avatar is tapped.
  final bool isNetworkImage; // Indicates whether the image is a network image or a local asset.

  const CustomCircleAvatar({
    Key? key,
    required this.onTap,
    required this.imagePath,
    this.isNetworkImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap, // Assigns the onTap callback to the GestureDetector's onTap property.
        child: CircleAvatar(
          backgroundColor: Colors.transparent, // Sets the background color of the CircleAvatar to transparent.
          radius: 30, // Sets the radius of the CircleAvatar.
          child: isNetworkImage
              ? SvgPicture.network(imagePath) // If isNetworkImage is true, load the image from the network using SvgPicture.network.
              : SvgPicture.asset(imagePath), // If isNetworkImage is false, load the image from the local assets using SvgPicture.asset.
        ),
      ),
    );
  }
}