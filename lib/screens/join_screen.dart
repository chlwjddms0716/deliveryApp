import 'package:deliveryapp/Models/DeliveryUser.dart';
import 'package:deliveryapp/Wigets/popup_widget.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/firebase/Database.dart';
import 'package:deliveryapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({
    super.key,
  });

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool isInput = false;
  bool isMSelect = false;
  bool isWSelect = false;

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

  void checkText(String text) {
    setState(() {
      if (nameController.text.isNotEmpty &&
          birthController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          idController.text.isNotEmpty &&
          pwController.text.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    });
  }

  void createUser() async {
    DeliveryUser? user;
    Future<DeliveryUser?> result = Authentication.createEmailAndPassword(
        idController.text, pwController.text);
    result
        .then((value) => {
              user = value!,
              user!.birth = birthController.text,
              user!.name = nameController.text,
              user!.gender = isMSelect
                  ? "M"
                  : isWSelect
                      ? "W"
                      : "X",
              user!.phoneNumber = phoneNumberController.text,
              insertUser(user!),
            })
        .catchError((error) => {showPopup(context, error.toString(), false)});
  }

  void insertUser(DeliveryUser user) {
    Future<bool> insertResult = Database.insertUser(user);
    insertResult.then((value) => {
          if (value)
            {
              showPopup(context, '회원가입 성공하였습니다.', true,
                  widget: const LoginScreen()),
              Authentication.loginUser = user
            }
          else
            {showPopup(context, '회원가입 실패하였습니다. 다시 시도해주세요.', false)}
        });
  }

  @override
  void initState() {
    isMSelect = false;
    isWSelect = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameController,
                    onChanged: checkText,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: '이름',
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
                  Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: TextField(
                          controller: birthController,
                          onChanged: checkText,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            labelText: '생년월일',
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
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isMSelect = true;
                              isWSelect = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isMSelect
                                  ? const Color(0xff2ac1bc)
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Text(
                              '남',
                              style: TextStyle(
                                color: isMSelect ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isMSelect = false;
                              isWSelect = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isWSelect
                                  ? const Color(0xff2ac1bc)
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Text(
                              '여',
                              style: TextStyle(
                                color: isWSelect ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                    controller: pwController,
                    onChanged: checkText,
                    obscureText: true,
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
                  TextField(
                    controller: phoneNumberController,
                    onChanged: checkText,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      labelText: '휴대전화 번호',
                      hintText: '휴대전화 번호를 입력해주세요.',
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
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isInput ? createUser : null,
                      style: !isInput ? defaultStyle : inputStyle,
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
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
