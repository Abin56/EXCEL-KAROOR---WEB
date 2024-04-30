import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_document/my_files/init.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vidyaveechi_website/model/class_model/class_model.dart';
import 'package:vidyaveechi_website/model/fees_model/fees_model_controller.dart';
import 'package:vidyaveechi_website/model/student_model/student_model.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';

class FeesAndBillsController extends GetxController {
  RxList<ClassModel> allClassList = RxList<ClassModel>();
  RxList<ClassModel> selectedClassList = RxList<ClassModel>();
  RxBool selectAllClass = false.obs;
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  RxBool ontapCreateFees = false.obs;
  RxBool ontapviewclasswiseFees = false.obs;
  RxInt classinitalFee = 0.obs;
  RxInt studentClassWiseCount = 0.obs;
  List<StudentModel> studentData = [];
  Future<int> fetchInitalClassFee(String classDocID) async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(classDocID)
        .get()
        .then((value) async {
      classinitalFee.value = value.data()!['classfee'];
    });
    return classinitalFee.value;
  }

  Future<RxList<ClassModel>> fetchClass() async {
    allClassList.clear();
    selectedClassList.clear();

    final firebase = await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => ClassModel.fromMap(e.data())).toList();
      allClassList.add(list[i]);
    }
    return allClassList;
  }

  TextEditingController feestypeNameContoller = TextEditingController();
  TextEditingController feesContoller = TextEditingController();
  TextEditingController feesDueContoller = TextEditingController();
  Future<void> addCustomFessAsignToClass() async {
    buttonstate.value = ButtonState.loading;
    final ClassFeesModel feesDetail = ClassFeesModel(
        docid: seletedFeeDateContoller.text.trim(),
        feestypeName: feestypeNameContoller.text,
        fees: int.parse(feesContoller.text.trim()),
        createdDate: DateTime.now(),
        dueDate: DateTime.now()
            .add(Duration(days: int.parse(feesDueContoller.text.trim()))));
    try {
      for (var i = 0; i < selectedClassList.length; i++) {
        await server
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(selectedClassList[i].docid)
            .collection("ClassFees")
            .doc(selectedFeeMonthContoller.text.trim())
            .set({'docid': selectedFeeMonthContoller.text.trim()}).then(
                (value) async {
          await feesCollection(
                  data: feesDetail,
                  docid: selectedFeeMonthContoller.text.trim(),
                  dateDocid: feesDetail.docid)
              .then((value) async {
            await getStudentClassWiseCount(
                selectedClassList[i].docid,
                selectedFeeMonthContoller.text.trim(),
                classinitalFee.value,
                feesDetail.docid);
          });
          await server
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(selectedClassList[i].docid)
              .collection("ClassFees")
              .doc(selectedFeeMonthContoller.text.trim())
              .collection(seletedFeeDateContoller.text.trim())
              .doc(feesDetail.docid)
              .set(feesDetail.toMap())
              .then((value) async {
            feestypeNameContoller.clear();
            feesContoller.clear();
            feesDueContoller.clear();
            seletedFeeDateContoller.clear();
            selectedFeeMonthContoller.clear();
            buttonstate.value = ButtonState.success;
            await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
              buttonstate.value = ButtonState.idle;
            });
            Get.back();
            Get.back();
            selectedClassList.clear();
            allClassList.clear();
            showToast(msg: 'Fees Genrated Completed');
          });
        });
      }
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> addFessAsignToClass() async {
    buttonstate.value = ButtonState.loading;
    final ClassFeesModel feesDetail = ClassFeesModel(
        docid: seletedFeeDateContoller.text.trim(),
        feestypeName: feestypeNameContoller.text,
        fees: classinitalFee.value,
        createdDate: DateTime.now(),
        dueDate: DateTime.now()
            .add(Duration(days: int.parse(feesDueContoller.text.trim()))));
    try {
      for (var i = 0; i < selectedClassList.length; i++) {
        await fetchInitalClassFee(selectedClassList[i].docid)
            .then((value) async {
          feesDetail.fees = classinitalFee.value;
          await server
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(selectedClassList[i].docid)
              .collection("ClassFees")
              .doc(selectedFeeMonthContoller.text.trim())
              .set({'docid': selectedFeeMonthContoller.text.trim()}).then(
                  (value) async {
            await feesCollection(
                    data: feesDetail,
                    dateDocid: feesDetail.docid,
                    docid: selectedFeeMonthContoller.text.trim())
                .then((value) async {
              await getStudentClassWiseCount(
                  selectedClassList[i].docid,
                  selectedFeeMonthContoller.text.trim(),
                  classinitalFee.value,
                  feesDetail.docid);
            });
            await server
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('classes')
                .doc(selectedClassList[i].docid)
                .collection("ClassFees")
                .doc(selectedFeeMonthContoller.text.trim())
                .collection(seletedFeeDateContoller.text.trim())
                .doc(feesDetail.docid)
                .set(feesDetail.toMap())
                .then((value) async {
              feestypeNameContoller.clear();
              feesContoller.clear();
              feesDueContoller.clear();
              seletedFeeDateContoller.clear();
              selectedFeeMonthContoller.clear();
              buttonstate.value = ButtonState.success;
              await Future.delayed(const Duration(seconds: 2)).then((vazlue) {
                buttonstate.value = ButtonState.idle;
              });
              Get.back();
              Get.back();
              selectedClassList.clear();
              allClassList.clear();

              showToast(msg: 'Fees Genrated Completed');
            });
          });
        });
      }
    } catch (e) {
      showToast(msg: 'Somthing went wrong please try again');
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  TextEditingController seletedFeeDateContoller = TextEditingController();
  TextEditingController selectedFeeMonthContoller = TextEditingController();
  final Rxn<DateTime> _selectedFeeDate = Rxn<DateTime>();
  final Rxn<DateTime> _selectedMonth = Rxn<DateTime>();
  selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth.value ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      // builder: (context, child) {},
    );
    if (picked != null && picked != _selectedMonth.value) {
      _selectedMonth.value = picked;
      DateTime parseDate = DateTime.parse(_selectedMonth.value.toString());
      final DateFormat formatter = DateFormat('yyyy-MMMM');
      String formatted = formatter.format(parseDate);

      selectedFeeMonthContoller.text = formatted.toString();
    }
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFeeDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedFeeDate.value) {
      _selectedFeeDate.value = picked;
      DateTime parseDate = DateTime.parse(_selectedFeeDate.value.toString());
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      seletedFeeDateContoller.text = formatted.toString();
    }
  }

  Future<void> feesCollection(
      {required ClassFeesModel data,
      required String docid,
      required String dateDocid}) async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(docid)
        .set({'docid': docid}, SetOptions(merge: true));
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(docid)
        .collection(docid)
        .doc(dateDocid)
        .set(data.toMap(), SetOptions(merge: true));
  }

  Future<void> getStudentClassWiseCount(String classDocID,
      String feeCollectionID, int fee, String dataDocID) async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(classDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final list =
            value.docs.map((e) => StudentModel.fromMap(e.data())).toList();
        studentData.add(list[i]);
        await server
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('FeesCollection')
            .doc(feeCollectionID)
            .collection(feeCollectionID)
            .doc(dataDocID)
            .collection('Students')
            .doc(studentData[i].docid)
            .set({
          'docid': studentData[i].docid,
          'StudentName': studentData[i].studentName,
          'fee': fee,
          'feepaid': false,
          'classID': studentData[i].classId,
          'paid': 0,
          'editFee': false,
        }, SetOptions(merge: true));
      }
    }).then((value) async {
      await getFeeTotalAmount(feeCollectionID, fee, dataDocID);
    });
  }

  Future<void> getFeeTotalAmount(
    String feeCollectionID,
    int fee,
    String dateDocID,
  ) async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(feeCollectionID)
        .collection(feeCollectionID)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      await server
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('FeesCollection')
          .doc(feeCollectionID)
          .collection(feeCollectionID)
          .doc(dateDocID)
          .set({
        'totalStudents': value.docs.length,
        'totalAmount': fee * value.docs.length,
        'collectedAmount': 0,
        'pendingAmount': 0,
      }, SetOptions(merge: true));
    });
  }

  RxList feeMonthList = [].obs;
  RxList feeDateList = [].obs;

  RxString feeMonthData = 'd'.obs;
  RxString feeDateData = 'd'.obs;
  Future<List> fetchFeeMonthData() async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        feeMonthList.add(value.docs[i]['docid']);
      }
    });
    log("message $feeDateList");
    return feeMonthList;
  }

  Future<List> fetchFeeDateData() async {
    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        feeDateList.add(value.docs[i]['docid']);
      }
    });
    return feeDateList;
  }

  final RxInt paidFee = 0.obs;
  pendingAmountCalculate(String dateDocID) async {
    int totalAmount = 0;

    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['paid'];
        log("totaladdesult $totaladdesult");
        totalAmount += totaladdesult;
      }

      paidFee.value = totalAmount;

      // .update({'totalAmount': totalResult.value});
    }).then((value) async {
      await server
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .get()
          .then((value) async {
        int totalAmount = value.data()!['totalAmount'] ?? 0;
        int result = totalAmount - paidFee.value;

        await server
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('FeesCollection')
            .doc(feeMonthData.value)
            .collection(feeMonthData.value)
            .doc(dateDocID)
            .update({'pendingAmount': result});
      });
    });
  }

  final RxInt initialFeeResult = 0.obs;
  final RxInt totalResult = 0.obs;

  bugCalculateTotalamount(String dateDocID, int totalStudent) async {
    int totalAmount = 0;

    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['fee'];
        log("totaladdesult $totaladdesult");
        totalAmount += totaladdesult;
      }

      totalResult.value = totalAmount;
      log("totalResult ${totalResult.value}");

      await server
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .update({'totalAmount': totalResult.value});
    });
  }

  final RxInt collectedFee = 0.obs;
  collectedAmountCalculate(String dateDocID) async {
    int totalAmount = 0;

    await server
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('FeesCollection')
        .doc(feeMonthData.value)
        .collection(feeMonthData.value)
        .doc(dateDocID)
        .collection('Students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        final int totaladdesult = value.docs[i].data()['paid'];
        log("totaladdesult $totaladdesult");
        totalAmount += totaladdesult;
      }

      collectedFee.value = totalAmount;

      // .update({'totalAmount': totalResult.value});
    }).then((value) async {
      await server
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('FeesCollection')
          .doc(feeMonthData.value)
          .collection(feeMonthData.value)
          .doc(dateDocID)
          .get()
          .then((value) async {
        await server
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('FeesCollection')
            .doc(feeMonthData.value)
            .collection(feeMonthData.value)
            .doc(dateDocID)
            .update({'collectedAmount': collectedFee.value});
      });
    });
  }
}
