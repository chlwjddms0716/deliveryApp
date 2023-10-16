import 'package:deliveryapp/Wigets/popup_widget.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:deliveryapp/firebase/Database.dart';
import 'package:deliveryapp/screens/userInfo_screen.dart';
import 'package:flutter/material.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  TextEditingController birthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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

  String gender = "X";
  bool isInput = false;

  void checkText(String text) {
    setState(() {
      if (birthController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty) {
        isInput = true;
      } else {
        isInput = false;
      }
    });
  }

//i love you
  void init() {
    print('UserEditScreen Init');
    String gender = Authentication.loginUser!.gender;

    birthController.text = Authentication.loginUser!.birth;
    phoneNumberController.text = Authentication.loginUser!.phoneNumber;

    checkText('');
  }

  void editUser() {
    Future<bool> result = Database.updatebyKey(
        phoneNumberController.text, gender, birthController.text);

    result
        .then((value) => showPopup(context, '업데이트 성공하였습니다.', true,
            widget: const UserInfoScreen()))
        .catchError(
            (onError) => {showPopup(context, onError.toString(), false)});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('내 정보 수정'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Authentication.loginUser!.imgUrl.isEmpty == true
                  ? Image.asset(
                      'assets/images/user_icon.png',
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      Authentication.loginUser!.imgUrl,
                      headers: const {"User-Agent": "Mozilla/5.0"},
                      height: 80,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 30,
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
                        gender = "M";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: gender == "M"
                            ? const Color(0xff2ac1bc)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        '남',
                        style: TextStyle(
                          color: gender == "M" ? Colors.white : Colors.grey,
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
                        gender = "W";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: gender == "W"
                            ? const Color(0xff2ac1bc)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        '여',
                        style: TextStyle(
                          color: gender == "W" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: phoneNumberController,
              onChanged: checkText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
                onPressed: isInput ? editUser : null,
                style: !isInput ? defaultStyle : inputStyle,
                child: const Text(
                  '수정완료',
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
    );
  }
}
