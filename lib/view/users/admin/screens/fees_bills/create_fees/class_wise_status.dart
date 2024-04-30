import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/fees_N_bills_Controller/feeStudent_controller.dart';
import 'package:vidyaveechi_website/controller/fees_N_bills_Controller/fees_bills_controller.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/constant/const.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/students/student_details/widgets/category_tableHeader.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/data_list_widgets/data_container.dart';
import 'package:vidyaveechi_website/view/widgets/loading_widget/loading_widget.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';
import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/route_NonSelectedContainer.dart';

class ClassWiseFeesStatus extends StatelessWidget {
  const ClassWiseFeesStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: screenContainerbackgroundColor,
        height: 700,
        width: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: TextFontWidget(
                text: 'Fee Details',
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 08,
                      right: 05,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.find<FeesAndBillsController>()
                            .ontapviewclasswiseFees
                            .value = false;
                      },
                      child: const RouteNonSelectedTextContainer(title: 'Home'),
                    ),
                  ),
                  const RouteSelectedTextContainer(
                      width: 140, title: 'Fees Deatils'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: cWhite,
                width: double.infinity,
                height: ResponsiveWebSite.isMobile(context) ? 800 : 500,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Container(
                        color: cWhite,
                        height: 40,
                        child: const Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'No')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 4,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Student Name')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Class')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Fee')),
                            SizedBox(
                              width: 02,
                            ),
                            Expanded(
                                flex: 2,
                                child: CatrgoryTableHeaderWidget(
                                    headerTitle: 'Paid')),
                            SizedBox(
                              width: 02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: StreamBuilder(
                            stream: server
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId!)
                                .collection('FeesCollection')
                                .doc(Get.find<FeesAndBillsController>()
                                    .feeMonthData
                                    .value)
                                .collection(Get.find<FeesAndBillsController>()
                                    .feeMonthData
                                    .value)
                                .doc(Get.find<FeesAndBillsController>()
                                    .feeDateData
                                    .value)
                                .collection('Students')
                                .orderBy(
                                  'feepaid',
                                )
                                .snapshots(),
                            builder: (context, snaps) {
                              if (snaps.hasData) {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      final data =
                                          snaps.data!.docs[index].data();
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: ClassWiseFeesDataListContainer(
                                            studentdata: data, index: index),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 02,
                                      );
                                    },
                                    itemCount: snaps.data!.docs.length);
                              } else {
                                return const LoadingWidget();
                              }
                            }))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassWiseFeesDataListContainer extends StatelessWidget {
  final Map<String, dynamic> studentdata;
  final int index;
  const ClassWiseFeesDataListContainer({
    required this.index,
    super.key,
    required this.studentdata,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: studentdata['feepaid'] == false
          ? Colors.red.withOpacity(0.1)
          : Colors.green.withOpacity(0.1),
      height: 35,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.center,
                // width: 150,
                index: index,
                headerTitle: '${index + 1}'), //....................No
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 4,
            child: DataContainerWidget(
                rowMainAccess: MainAxisAlignment.start,
                index: index,
                headerTitle: "  ${studentdata['StudentName']}"),
          ), //................................................. Months
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
                stream: server
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(studentdata['classID'])
                    .snapshots(),
                builder: (context, result) {
                  if (result.hasData) {
                    return DataContainerWidget(
                        rowMainAccess: MainAxisAlignment.center,
                        index: index,
                        headerTitle: " ${result.data!.data()!['className']}");
                  } else {
                    return const Center(
                      child: circularPIndicator,
                    );
                  }
                }),
          ), //........................................... Subjects
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: studentdata['editFee'] == true
                ? StudentFeesEditWidget(docid: studentdata['docid'])
                : Row(
                    children: [
                      DataContainerWidget(
                          rowMainAccess: MainAxisAlignment.center,
                          index: index,
                          headerTitle: " ${studentdata['fee']}"),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () async {
                              Get.find<StudentFeeController>()
                                  .feeEditController(
                                      studentdata['docid'], true);
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: cgreen,
                              size: 20,
                            )),
                      )
                    ],
                  ),
          ), //....................................... Fess Collectes
          Container(
            color: cWhite,
            width: 02,
          ),
          Expanded(
            flex: 2,
            child: studentdata['feepaid'] == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // webassets\png\not_active.png
                      SizedBox(
                        width: 15,
                        child: Image.asset(
                          'webassets/png/not_active.png',
                        ),
                      ),
                       TextFontWidget(
                        text: " Pending",
                        fontsize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () async {
                              Get.find<StudentFeeController>()
                                  .updateStudentFeeStatus(studentdata['docid'],
                                      true, studentdata['fee']);
                            },
                            icon: const Icon(
                              Icons.check,
                              color: cgreen,
                              size: 20,
                            )),
                      ),
                       TextFontWidget(
                        text: 'Paid?',
                        fontsize: 12,
                        color: cgreen,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      SizedBox(
                        width: 15,
                        child: Image.asset(
                          'webassets/png/active.png',
                        ),
                      ),
                       TextFontWidget(
                        text: " Full Paid",
                        fontsize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                            onPressed: () async {
                              Get.find<StudentFeeController>()
                                  .updateStudentFeeStatus(
                                      studentdata['docid'], false, 0);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: cgreen,
                              size: 20,
                            )),
                      ),
                      TextFontWidget(
                        text: 'Not Paid?',
                        fontsize: 12,
                        color: cgreen,
                      ),
                    ],
                  ),
          ),
          Container(
            color: cWhite,
            width: 02,
          ),
        ],
      ),
    );
  }
}

class StudentFeesEditWidget extends StatelessWidget {
  final String docid;
  const StudentFeesEditWidget({super.key, required this.docid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 35,
            child: Center(
              child: TextFormField(
                controller:
                    Get.find<StudentFeeController>().updateFeeController,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 01, horizontal: 01),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Colors.red,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: Colors.red,
                    ),
                  ),
                  // contentPadding: const EdgeInsets.all(8.0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 0.4)),
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: "  Enter Fee",
                  focusedBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              await Get.find<StudentFeeController>()
                  .updateStudentFeeInFeeBill(docid);
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: cBlack.withOpacity(0.2))),
              child:  Center(
                child: TextFontWidget(
                  text: '✔️',
                  fontsize: 12,
                  fontWeight: FontWeight.bold,
                  color: cgreen,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              await Get.find<StudentFeeController>().feeEditController(
                docid,
                false,
              );
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: cBlack.withOpacity(0.2))),
              child:  Center(
                child: TextFontWidget(
                  text: '✖️',
                  fontsize: 12,
                  fontWeight: FontWeight.bold,
                  color: cred,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
