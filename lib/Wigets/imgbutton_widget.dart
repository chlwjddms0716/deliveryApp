import 'package:flutter/material.dart';

class ImgButton extends StatelessWidget {
  String text = "", imgAds = "";
  Widget nextPage;

  ImgButton(
      {super.key,
      required this.text,
      required this.imgAds,
      required this.nextPage});

  Color greyColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
      child: Container(
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          Image.asset(
            'assets/images/$imgAds.png',
            width: 25,
            height: 25,
            color: greyColor,
          ),
          Text(
            text,
            style: TextStyle(
              color: greyColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    );
  }
}
