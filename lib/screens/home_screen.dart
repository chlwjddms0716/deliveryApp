import 'package:carousel_slider/carousel_slider.dart';
import 'package:deliveryapp/Wigets/category_widget.dart';
import 'package:deliveryapp/Wigets/imgbutton_widget.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/screens/addressEdit_screen.dart';
import 'package:deliveryapp/screens/userInfo_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  Color baeminColor = const Color(0xff2ac1bc);

  List<Map<String, String>> categorys = [
    {'text': '1인분', 'imgAds': 'heart_icon'},
    {'text': '족발·보쌈', 'imgAds': 'heart_icon'},
    {'text': '찜·탕·찌개', 'imgAds': 'heart_icon'},
    {'text': '돈까스·회·일식', 'imgAds': 'heart_icon'},
    {'text': '피자', 'imgAds': 'heart_icon'},
    {'text': '고기·구이', 'imgAds': 'heart_icon'},
    {'text': '야식', 'imgAds': 'heart_icon'},
    {'text': '양식', 'imgAds': 'heart_icon'},
    {'text': '치킨', 'imgAds': 'heart_icon'},
    {'text': '중식', 'imgAds': 'heart_icon'},
    {'text': '아시안', 'imgAds': 'heart_icon'},
    {'text': '백반·죽·국수', 'imgAds': 'heart_icon'},
    {'text': '도시락', 'imgAds': 'heart_icon'},
    {'text': '분식', 'imgAds': 'heart_icon'},
    {'text': '카페·디저트', 'imgAds': 'heart_icon'},
    {'text': '패스트푸트', 'imgAds': 'heart_icon'},
    {'text': '브랜드관', 'imgAds': 'heart_icon'},
    {'text': '맛집랭킹', 'imgAds': 'heart_icon'},
    {'text': '게임기', 'imgAds': 'heart_icon'},
    {'text': '뷰티', 'imgAds': 'heart_icon'},
    {'text': '편의점', 'imgAds': 'heart_icon'},
    {'text': '식료품점', 'imgAds': 'heart_icon'},
    {'text': '반찬가게', 'imgAds': 'heart_icon'},
    {'text': '반찬가게', 'imgAds': 'heart_icon'},
    {'text': '홈데코·리빙샵', 'imgAds': 'heart_icon'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: baeminColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (Authentication.loginUser != null) {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )),
                                builder: ((BuildContext context) {
                                  return AddressScreen();
                                }));
                          }
                        },
                        child: Row(
                          children: [
                            const Text(
                              '주소',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Image.asset(
                              'assets/images/down_triangle_icon.png',
                              width: 19,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: baeminColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              onTap: () {},
                              controller: searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.search),
                                prefixIconColor: baeminColor,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                hintText: '찾는 맛집 이름이 뭐예요?',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          width: double.infinity,
                          height: 240,
                          color: Colors.grey,
                          child: Image.asset(
                              'assets/images/banner/${index + 1}.jpg',
                              fit: BoxFit.cover),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        initialPage: 0,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categorys.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, //1 개의 행에 보여줄 item 개수
                          childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
                          mainAxisSpacing: 5, //수평 Padding
                          crossAxisSpacing: 5, //수직 Padding
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          //item 의 반목문 항목 형성
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                            ),
                            child: CategoryWidget(
                                name: (categorys[index])['text'].toString(),
                                imageAds:
                                    (categorys[index])['imgAds'].toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImgButton(
                  text: '검색',
                  imgAds: 'search_outline_icon',
                  nextPage: const UserInfoScreen(),
                ),
                ImgButton(
                  text: '찜',
                  imgAds: 'heart_icon',
                  nextPage: const UserInfoScreen(),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/home_icon.png',
                    height: 55,
                    width: 55,
                  ),
                ),
                ImgButton(
                  text: '주문내역',
                  imgAds: 'receipt_icon',
                  nextPage: const UserInfoScreen(),
                ),
                ImgButton(
                  text: 'my배민',
                  imgAds: 'smile_icon',
                  nextPage: const UserInfoScreen(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
