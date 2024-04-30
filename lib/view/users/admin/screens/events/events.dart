
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/controller/event_controller/event_controller.dart';
import 'package:vidyaveechi_website/model/event_models/events_model.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/google_poppins_widget.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/events/create_event.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/events/functions/delete.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/events/functions/edit.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';

// class EventsEditREmove extends StatelessWidget {
//    EventsEditREmove({
//     Key? key,
//     // required this.schoolID
//   }) : super(key: key);

// final EventController eventController = Get.put(EventController());
//   // String schoolID;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: screenContainerbackgroundColor,
//       height: 800,
//       width: 1000,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: GooglePoppinsWidgets(
//               text: 'Events ',
//               fontsize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           CreateEvent(),
//           Expanded(
//             child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('SchoolListCollection')
//                     .doc(UserCredentialsController.schoolId)
//                     .collection(UserCredentialsController.batchId!)
//                     .doc(UserCredentialsController.batchId!)
//                     .collection('AdminEvents')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   // ignore: prefer_is_empty
//                   if (snapshot.data!.docs.length == 0) {
//                     return Center(
//                         child: Text(
//                       'No Events',
//                       style: GoogleFonts.poppins(
//                           fontSize: 20, fontWeight: FontWeight.w500),
//                     ));
//                   }
//                   return GridView.count(
//                     crossAxisCount: ResponsiveWebSite.isMobile(context) ? 1: ResponsiveWebSite.isTablet(context)  ? 3  : 4,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     children:
//                         List.generate(snapshot.data!.docs.length, (index) {
//                            final data = EventModel.fromMap(
//                              snapshot.data!.docs[index].data());
//                       return Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Container(
//                           height: 200,
//                           width: 300,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: cWhite,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 10, left: 10),
//                                 child: GooglePoppinsWidgets(
//                                   text: snapshot.data!.docs[index]['eventName'],
//                                   fontsize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, top: 10),
//                                 child: GooglePoppinsWidgets(
//                                   text: snapshot.data!.docs[index] ['eventDescription'],
//                                   fontsize: 14,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 10,
//                                   bottom: 10,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: MaterialButton(
//                                           onPressed: () {
//                                             editFunctionOfEvent(context, data);
//                                             // customShowDilogBox(
//                                             //     context: context,
//                                             //     title: 'Edit',
//                                             //     children: [
//                                             //       TextFormFiledBlueContainerWidgetEvent(
//                                             //           hintText: ' ${snapshot.data!.docs[index]['eventName']}',
//                                             //           title: 'Event'),
//                                             //       TextFormFiledBlueContainerWidgetEvent(
//                                             //           hintText: ' ${snapshot.data!.docs[index]['eventDate']}',
//                                             //           title: 'Date'),
//                                             //       TextFormFiledBlueContainerWidgetEvent(
//                                             //           hintText: ' ${snapshot.data!.docs[index]['venue']}',
//                                             //           title: 'Venue'),
//                                             //       TextFormFiledBlueContainerWidgetEvent(
//                                             //           hintText: ' ${snapshot.data!.docs[index]['eventDescription']}',
//                                             //           title: 'Description'),
//                                             //       TextFormFiledBlueContainerWidgetEvent(
//                                             //           hintText: ' ${snapshot.data!.docs[index]['signedBy']}',
//                                             //           title: 'Signed by')
//                                             //     ],
//                                             //     doyouwantActionButton: true,
//                                             //     actiononTapfuction: () {
//                                             //       eventController.updateEvent(context,data.id);
//                                             //   //      // ignore: unused_local_variable
//                                             //   //      String edit = snapshot.data!
//                                             //   //     .docs[index]['eventName'];

//                                             //   // FirebaseFirestore.instance
//                                             //   //     .collection('SchoolListCollection')
//                                             //   //      .doc(UserCredentialsController.schoolId)
//                                             //   //      .collection(UserCredentialsController.batchId!)
//                                             //   //      .doc(UserCredentialsController.batchId!)
//                                             //   //     .collection('AdminEvents')
//                                             //   //     .doc(snapshot
//                                             //   //         .data!.docs[index]['id'])
//                                             //   //     .update({
//                                             //   //       'eventDate': eventController.eventdateController.text,
//                                             //   //       'eventName': eventController.eventnameController.text,
//                                             //   //       'eventDescription': eventController.eventdescriptionController.text,
//                                             //   //       'venue': eventController.eventvenueController.text,
//                                             //   //       'signedBy':eventController.eventsignedByController.text,
//                                             //   //     })
//                                             //   //     .then((value) =>
//                                             //   //         Navigator.pop(context))
//                                             //   //     .then((value) => showToast(
//                                             //   //         msg: 'Event Updated!'));
//                                             //     },
//                                             //     actiontext: 'Update');
//                                           },
//                                           color: cBlue,
//                                           child: GooglePoppinsWidgets(
//                                             text: 'Edit',
//                                             fontsize: 13,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: 10,
//                                           right: 10,
//                                         ),
//                                         child: MaterialButton(
//                                           onPressed: () {
//                                             deleteFunctionOfEvents(context, data);
//                                              },
//                                            color: cred,
//                                            child: GooglePoppinsWidgets(
//                                             text: 'Delete',
//                                             fontsize: 13,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
// final EventController eventController = Get.put(EventController());
// ignore: must_be_immutable
class TextFormFiledBlueContainerWidgetEvent extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  final String title;
  final String hintText;
  final Widget? widget;
  Function(String)? onChanged;
  Iterable<String>? autofillHints;
  String? Function(String?)? validator;
  Function()? onTap;
  TextInputType? keyboardType;
  TextFormFiledBlueContainerWidgetEvent({
    this.widget,
    required this.hintText,
    required this.title,
    this.keyboardType,
    this.controller,
    this.autofillHints,
    this.onChanged,
    this.validator,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextFontWidget(text: '$title *', fontsize: 12.5),
              widget == null ? const SizedBox() : widget!,
            ],
          ),
          const SizedBox(
            height: 05,
          ),
          Container(
            height: 60,
            width: 500,
            color: screenContainerbackgroundColor,
            child: Center(
              child: TextFormField(
                maxLines: 5,
                onChanged: onChanged,
                autofillHints: autofillHints,
                onTap: onTap,
                validator: validator,
                keyboardType: keyboardType,
                controller: controller,
                decoration: InputDecoration(
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Colors.red,
                      )),
                  focusedErrorBorder: const OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: Colors.red,
                    ),
                  ),
                  // contentPadding: const EdgeInsets.all(8.0),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.4)),
                  hintStyle: const TextStyle(fontSize: 13),
                  hintText: hintText,
                  focusedBorder: const OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
