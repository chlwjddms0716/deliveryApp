import 'package:flutter/material.dart';

void showPopup(BuildContext context, String msg, bool isSuccess,
    {Widget? widget}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('팝업 메세지'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(msg),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (isSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget!,
                      ));
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      });
}
