import 'package:deliveryapp/Wigets/address_widget.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/screens/addressSearch_screen.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  Color greyColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: MediaQuery.of(context).size.height * 0.88,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '편집',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const Text(
                      '주소 설정',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '편집',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onTap: () {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor,
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.grey.shade500,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    hintText: '지번, 도로명, 건물명으로 검색',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: greyColor,
                    )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greyColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    // 지도
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.location_city,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '현재 위치로 설정',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.grey.shade500,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: greyColor,
            ),
          ),
          if (Authentication.loginUser!.ads.home.isNotEmpty)
            AddressWidget(
                keyword: 'home', address: Authentication.loginUser!.ads.home),
          if (Authentication.loginUser!.ads.company.isNotEmpty)
            AddressWidget(
                keyword: 'company',
                address: Authentication.loginUser!.ads.company),
        ],
      ),
    );
  }
}
