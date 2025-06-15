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
      margin: const EdgeInsets.only(right: 10, bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],// soft sky blue
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // ⭐ Rating
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // 💵 Price
                Text(
                  'JD $price/hr',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D47A1),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // 📞 Contact and Description
          Column(
            children: [
              // 📞 Phone
              InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // 🟢 WhatsApp
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
                  width: 28,
                  height: 28,
                ),
              ),

              const SizedBox(height: 6),

              // 🟠 Description
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
                    fontSize: 13,
                    color: Color(0xFF0D47A1),
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
