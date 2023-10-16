import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/screens/home_screen.dart';
import 'package:deliveryapp/screens/login_screen.dart';
import 'package:deliveryapp/screens/userEdit_screen.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool isLoginSuccess = false;
  @override
  void initState() {
    if (Authentication.loginUser != null) {
      isLoginSuccess = true;
    } else {
      isLoginSuccess = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text('my배민'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: const Center(
              child: Text(
                '배민 잘 쓰는 법 알려드려요',
                textAlign: TextAlign.left,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              !isLoginSuccess
                  ? Navigator.pushReplacementNamed(context, '/login')
                  : Navigator.pushReplacementNamed(context, '/userEdit');
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/user_icon.png',
                            width: 50,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            !isLoginSuccess
                                ? '로그인해주세요.'
                                : Authentication.loginUser!.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
