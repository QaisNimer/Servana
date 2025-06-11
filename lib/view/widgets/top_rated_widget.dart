import 'package:flutter/material.dart';

class TopRatedWidget extends StatelessWidget {
  final String title;
  final String description;
 // final String price;
  final String imagePath;
  final double rating;
  final VoidCallback onPressed;

  const TopRatedWidget({
    required this.title,
    required this.description,
  //  required this.price,
    required this.imagePath,
    required this.rating,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,

      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 8),
          Image.asset(imagePath, height: 108),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              SizedBox(width: 5),
              Text(rating.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 7,),
              Text(description, style: TextStyle(fontSize: 17,))
            ],
          ),

        ],
      ),
    );
  }
}