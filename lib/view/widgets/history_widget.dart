import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servana/view/screens/section_4/rating_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryWidget extends StatelessWidget {
  final String title;
  final String description;
  final String description1;
  final String date;
  final String? description2;

  // final double rating;
  final String price;
//  final VoidCallback onPressed;

  const HistoryWidget({
    required this.title,
    required this.description,
    required this.description1,
    required this.date,
     this.description2,
    //  required this.imagePath,
    //  required this.rating,
    required this.price,
   // required this.onPressed,
    // this.whatsappNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👤 Avatar
          // CircleAvatar(
          //   radius: 40,
          //   backgroundImage: AssetImage(imagePath),
          // ),
          const SizedBox(width: 12),

          // 📋 Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.orangeAccent,
                  ),
                ),
                Text(
                  date,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),

                const SizedBox(height: 6),

                //  Row(),
                // 💵 Price
                Text(
                  '\$ $price/hr',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(90, 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Rate Worker",
                  style: TextStyle(color: Colors.white),
                ),
              ),


              SizedBox(height: 8),

              // 🟠 Description Button
              ElevatedButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(90, 35),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.orange),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
