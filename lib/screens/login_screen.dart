import 'package:deliveryapp/Models/DeliveryUser.dart';
import 'package:deliveryapp/Wigets/popup_widget.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/firebase/Database.dart';
import 'package:deliveryapp/screens/join_screen.dart';
import 'package:deliveryapp/screens/userInfo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  String userUid = "";
  bool isInput = false;
  bool isLoginSuccess = false;
  late SharedPreferences prefs;

  ButtonStyle defaultStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ));
  ButtonStyle inputStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff2ac1bc),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ));

  @override
  void initState() {
    isInput = false;
    super.initState();
  }

  void loginWithEmailorId() {
    Future<User?> user = Authentication.signInWithEamilAndPassword(
        idController.text, pwController.text);
    user
        .then((value) => {
              if (value != null)
                {
                  userUid = Authentication.loginUser!.uid,
                  Navigator.pushReplacementNamed(context, '/userInfo')
                }
            })
        .catchError((error) => {showPopup(context, error.toString(), false)});
  }

  void loginWithGoogle() {
    DeliveryUser user;
    Future<User?> signResult = Authentication.signInWithGoogle();
    signResult
        .then((value) => {
              if (value != null)
                {
                  print('Login Success'),
                  user = DeliveryUser(
                      value.uid,
                      value.displayName.toString(),
                      '',
                      value.email.toString(),
                      '',
                      '',
                      value.phoneNumber.toString(),
                      value.photoURL.toString()),
                  insertUser(user),
                }
              else
                {print('loginWithGoogle value Null')}
            })
        .catchError((error) => {print(error)});
  }

  void insertUser(DeliveryUser user) {
    Future<bool> insertResult = Database.insertUser(user);
    insertResult.then((value) => {
          if (value)
            {
              print('insertUser Success'),
              Navigator.pushReplacementNamed(context, '/userInfo')
            }
          else
            {showPopup(context, '로그인 실패했습니다. 다시 시도해주세요.', false)}
        });
  }

  void checkText(String text) {
    setState(() {
      if (idController.text.isNotEmpty && pwController.text.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    });
  }

  void loginComplete() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUid', userUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  TextField(
                    controller: idController,
                    onChanged: checkText,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: '이메일 아이디',
                      hintText: '이메일 또는 아이디를 입력해주세요.',
                      labelStyle: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: pwController,
                    onChanged: checkText,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                      hintText: '비밀번호를 입력해주세요.',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isInput ? loginWithEmailorId : null,
                      style: !isInput ? defaultStyle : inputStyle,
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/join');
                      },
                      child: const Text(
                        '이메일로 회원가입',
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loginWithGoogle,
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(30),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_icon.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '구글로 계속하기',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
