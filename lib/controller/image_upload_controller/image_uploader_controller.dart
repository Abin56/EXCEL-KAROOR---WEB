import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';

class ImageController extends GetxController {
  Rxn<Uint8List> image = Rxn();

  // for Picking images from gallery //
  pickImage() async {
    try {
      XFile? pickimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickimage != null) {
        print("<>>>>>>>>>>>>>>>>>>>>>>>.gasudgisa");
        print(pickimage.readAsBytes());
        image.value = await pickimage.readAsBytes();
        updateProfilePicture();
        // return await pickimage.readAsBytes();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // images uploaded to firebase and return a image url //
  Future<String> uploapImageToFirebase(Uint8List image) async {
    String imageUrl = '';

    final imageName = 'image_${DateTime.now()}.jpg';
    Reference storageRef =
        FirebaseStorage.instance.ref().child('imagecollection$imageName');

    try {
      // final Uint8List imageByte = await image.readAsBytes();
      await storageRef.putData(image).whenComplete(
        () async {
          imageUrl = await storageRef.getDownloadURL();
        },
      );
      return imageUrl;
    } catch (e) {
      return "error";
    }
  }

  Future updateProfilePicture() async {
    // print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${image.value}');
    String uploadedImage = await uploapImageToFirebase(image.value!);
    print('Image converted');

    final Map<String, dynamic> updateData = {
      "image": uploadedImage,
    };
    try {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(serverAuth.currentUser!.uid)
          .update(updateData);
      showToast(msg: 'Profile picture updated');
    } catch (e) {
      log('Error updating profile picture: $e');
      showToast(msg: 'Failed to update profile picture');
    }
  }
}

class AdminProfileController extends GetxController {
  final getImageCtr = Get.put(ImageController());
  RxBool onTapEdit = false.obs;
  RxString gender = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future updateAdminProfile() async {
    final Map<String, dynamic> updateData = {
      "adminUserName": nameController.text,
      "designation": designationController.text,
      "about": aboutController.text,
      "phoneNumber": phoneController.text,
      "email": emailController.text,
      "gender": gender.value,
    };

    try {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(serverAuth.currentUser!.uid)
          .update(updateData)
          .then((_) => onTapEdit.value = false);
      showToast(msg: 'Profile updated');
    } catch (e) {
      log('Error updating profile: $e');
      showToast(msg: 'Failed to update profile');
    }
  }
}
