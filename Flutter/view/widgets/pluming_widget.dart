import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PlumingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double rating;
  final String price;
  final VoidCallback onPressed;
  final String? whatsappNumber;

  const PlumingWidget({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.price,
    required this.onPressed,
    this.whatsappNumber,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 👤 Avatar
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imagePath),
          ),
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
                const SizedBox(height: 6),

                // ⭐ Rating with 5 stars
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating, // pass your double rating value here
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      itemCount: 5,
                      itemSize: 23.0,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

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

          // 📞 Phone + WhatsApp + Description button
          Column(
            children: [
              // 📞 Phone button
              InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 🟢 WhatsApp icon
              InkWell(
                onTap: () async {
                  if (whatsappNumber != null) {
                    final url = Uri.parse("https://wa.me/$whatsappNumber");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Could not open WhatsApp"),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("WhatsApp number not available"),
                      ),
                    );
                  }
                },
                child: Image.asset(
                  'assets/images/whatsapp.jpg',
                  width: 32,
                  height: 32,
                ),
              ),

              const SizedBox(height: 4),

              // 🟠 Description Button
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                  ),
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
