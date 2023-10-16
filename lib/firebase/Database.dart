import 'package:deliveryapp/Models/DeliveryUser.dart';
import 'package:deliveryapp/firebase/Authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';

class Database {
  static var logger = Logger();

  static Future<bool> insertUser(DeliveryUser user) async {
    bool result = false;

    bool isExistUser = await checkUserbyKey(user.uid);
    if (isExistUser) {
      logger.i('Exist User');

      DeliveryUser? fUser = await Database.getUserbyKey(user.uid);
      if (fUser != null) {
        Authentication.loginUser = fUser;
        logger.i('insertUser Exist loginUser');
        logger.i(Authentication.loginUser!.uid);
        logger.i(Authentication.loginUser!.birth);
        logger.i(Authentication.loginUser!.phoneNumber);
      }
    } else {
      DatabaseReference ref = FirebaseDatabase.instance.ref("User/${user.uid}");
      Map<String, dynamic> map = {'home': '', 'company': ''};
      late Address ads = Address.fromJson(map);

      await ref.set({
        "name": user.name,
        "birth": user.birth,
        "email": user.email,
        "password": user.password,
        "imgUrl": user.imgUrl,
        "phoneNumber": user.phoneNumber,
        "gender": user.gender,
        "address": "",
      });

      await ref.child('/address').set({'home': '', 'company': ''});

      logger.i('getUser Key :${user.uid}');
      isExistUser = await checkUserbyKey(user.uid);

      DeliveryUser? fUser = await Database.getUserbyKey(user.uid);
      if (fUser != null) Authentication.loginUser = fUser;
    }

    result = isExistUser;
    return result;
  }

// 존재하는 key 값인지 확인
  static Future<bool> checkUserbyKey(String userKey) async {
    bool result = false;

    try {
      final ref = FirebaseDatabase.instance.ref();
      DataSnapshot snapshot = await ref.child('User/$userKey').get();
      if (snapshot.value != null) {
        result = true;
        logger.i('checkUserbyKey userData : ${snapshot.value}');
      } else {
        logger.i('No data available.');
      }
    } catch (error) {
      logger.e(error.toString());
    }

    logger.i('checkUserbyKey result : $result');
    return result;
  }

  static Future<bool> updatebyKey(
      String phoneNumber, String gender, String birth) async {
    bool result = false;
    Future<DeliveryUser?> fUser;

    try {
      final ref = FirebaseDatabase.instance.ref();
      await ref
          .child('User/${Authentication.loginUser!.uid}')
          .update({
            'birth': birth,
            'gender': gender,
            'phoneNumber': phoneNumber,
          })
          .then((value) => {
                logger.i('Update 완료'),
                result = true,
                fUser = Database.getUserbyKey(Authentication.loginUser!.uid),
                fUser.then((value) => {
                      logger.i('updatebyKey value $value'),
                      Authentication.loginUser = value
                    })
              })
          .catchError((onError) {
            Future.error('업데이트 실패 다시 시도해주세요.');
          });
    } catch (error) {
      logger.e(error.toString());
      Future.error('업데이트 실패 다시 시도해주세요.');
    }

    logger.i('updatebyKey result : $result');
    return result;
  }

  static Future<DeliveryUser?> getUserbyKey(String userKey) async {
    DeliveryUser? user;

    try {
      final ref = FirebaseDatabase.instance.ref();
      DataSnapshot snapshot = await ref.child('User/$userKey').get();
      if (snapshot.exists) {
        logger.i('snapshot value : ${snapshot.value}');
        if (snapshot.exists) {
          Map<String, dynamic> toMap =
              Map<String, dynamic>.from(snapshot.value as Map);

          user = DeliveryUser.fromJson(toMap);
          user.uid = userKey;
          logger.i('getUserbyKey value : ${snapshot.value}');
        } else {
          logger.i('No data available.');
        }
      } else {
        logger.i('No data available.');
      }
    } catch (error) {
      logger.e(error.toString());
    }

    logger.i('getUserbyKey Return : $user');
    return user;
  }

  static Future<Address?> getUserAddressbyKey(String userKey) async {
    DeliveryUser? user;
    try {
      final ref = FirebaseDatabase.instance.ref();

      DataSnapshot snapshot = await ref.child('User/$userKey').get();
      snapshot.ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          logger.i('snapshot value : ${event.snapshot.value}');
          if (event.snapshot.exists) {
            logger.i('checkUserbyEmail value : ${event.snapshot.value}');

            Map<String, dynamic> toMap =
                Map<String, dynamic>.from(event.snapshot.value as Map);

            Address ads = Address.fromJson(
                Map<String, dynamic>.from(toMap['address'] as Map));

            logger.i('toMap : $toMap');
            user = DeliveryUser.fromJson(toMap);

            logger.i('getUserAddressbyKey Address : ${user!.ads}');
          } else {
            logger.i('No data available.');
          }
        } else {
          logger.i('No data available.');
        }
      });
    } catch (error) {
      logger.e(error.toString());
    }

    return user!.ads;
  }
}
