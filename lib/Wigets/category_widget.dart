import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.name, required this.imageAds});

  String name = "", imageAds = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        width: 50,
        height: 50,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/$imageAds.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
      ),
    );
  }
}
