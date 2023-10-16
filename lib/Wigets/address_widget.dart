import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  String keyword = "";
  String address = "";

  AddressWidget({super.key, required this.keyword, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            keyword == "home"
                ? 'assets/images/house_icon.png'
                : 'assets/images/workplace_icon.png',
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  keyword == "home" ? '우리집' : "회사",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  address,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
