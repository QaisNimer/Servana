import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_4/rating_screen.dart';

class HistoryWidget extends StatelessWidget {
  final String title;
  final String description;
  final String description1;
  final String date;
  final String? description2;
  final String price;

  const HistoryWidget({
    required this.title,
    required this.description,
    required this.description1,
    required this.date,
    this.description2,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      margin: const EdgeInsets.only(right: 10, bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, // ✅ soft sky blue
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),

          // 📋 Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🧑‍🔧 Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 5),

                // 🧾 Description1
                Text(
                  description1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 25),

                // 📅 Date
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 18,),
                    Text(
                      'JD $price/hr',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 💵 Price

              ],
            ),
          ),

          const SizedBox(width: 10),

          // 📍 Buttons
          Column(
            children: [
              // ✅ Rate Worker Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D47A1),
                  minimumSize: const Size(100, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Rate Worker",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              // 📝 Description Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDAF6FF),
                  elevation: 0,
                  side: BorderSide(color: Color(0xFFDAF6FF), width: 1),
                  minimumSize: const Size(100, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black),
                  ),
                  //overflow: TextOverflow.ellipsis,
                ),
             // ),
            ],
          ),
        ],
      ),
    );
  }
}
