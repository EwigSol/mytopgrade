// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topgrade/models/user_model.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createUser(UserModel userModel) async {
    try {
      await firestore
          .collection("users")
          .doc(userModel.id.toString())
          .collection('userDetials')
          .doc('userDetials')
          .set({
        "id": userModel.id,
        "name": userModel.firstName,
        "email": userModel.email,
        "username": userModel.username,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Stream<List<UserModel>> userStreamm(String uid) {
  //   return firestore
  //       .collection('users')
  //       .doc(uid)
  //       .collection('userDetials')
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) {
  //     List<UserModel> retVal = [];
  //     querySnapshot.docs.forEach((element) {
  //       retVal.add(UserModel.fromFirestore(element));
  //     });
  //     return retVal;
  //   });
  // }

//   Future<void> addPhoneNumber(phone) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({"phone": phone});
//   }

//   Future<void> updateFrontImagePic(imageUrl) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({"frontImageUrl": imageUrl});
//   }

//   Future<void> updateInsideImagePic(imageUrl) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({"insideImageUrl": imageUrl});
//   }

//   Future<void> updateInsideImageTwoPic(imageUrl) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({"insideImageUrlTwo": imageUrl});
//   }

//   Future<void> updateBusinessInformation(
//       bsuinessName, fullName, businessPhone, refererName, refererPhone) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({
//       "name": fullName,
//       "businessName": bsuinessName,
//       "businessPhone": businessPhone,
//       "reffererName": refererName,
//       "reffererPhone": refererName,
//     });
//   }

//   Future<void> updateLocation(latitude, longitude) async {
//     await firestore
//         .collection("users")
//         .doc(userID.value)
//         .collection('userDetials')
//         .doc('userDetials')
//         .update({"latitude": latitude, "longitude": longitude});
//   }
}
