import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/meeting_controller/meeting_controller.dart';
import 'package:vidyaveechi_website/model/meeting_model/meeting_model.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/meeting/creating_meeting/create_meeting.dart';
import 'package:vidyaveechi_website/view/widgets/custom_delete_showdialog/custom_delete_showdialog.dart';
import 'package:vidyaveechi_website/view/widgets/custom_showdialouge/custom_showdialouge.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';


editFunctionOfMeeting(BuildContext context, MeetingModel data) {
  final MeetingController meetingController = Get.put(MeetingController());
  customShowDilogBox(
    context: context,
    title: 'Edit Meeting',
    children: [
      TextFormFiledBlueContainerWidgetMeeting(
        controller: meetingController.edittopicController,
          hintText: data.topic, title: 'Topic'),
      TextFormFiledBlueContainerWidgetMeeting(
        onTap: () {
          meetingController.selectDate(context, meetingController.editdateController);
        },
         controller: meetingController.editdateController,
          hintText: data.date, title: 'Date🗓️ '),
      TextFormFiledBlueContainerWidgetMeeting(
         controller: meetingController.edittimeController,
          hintText: data.time, title: 'Time '),
      TextFormFiledBlueContainerWidgetMeeting(
         controller: meetingController.editcategoryController,
          hintText: data.category, title: 'Category'),
      TextFormFiledBlueContainerWidgetMeeting(
         controller: meetingController.editvenueController,
          hintText: data.venue, title: 'Venue'),
      TextFormFiledBlueContainerWidgetMeeting(
         controller: meetingController.editmemberController,
          hintText: data.members, title: 'Expected Members'),
      TextFormFiledBlueContainerWidgetMeeting(
         controller: meetingController.editspecialguestController,
          hintText: data.specialGuest, title: 'Special Guest'),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //          meetingController.updateMeeting(
      //   data.meetingId, context);
      //       },
      //       child: Container(
      //         height: 40,
      //         width: 150,
      //         decoration: BoxDecoration(
      //             color: themeColorBlue,
      //             border: Border.all(color: themeColorBlue),
      //             borderRadius: BorderRadius.circular(05)),
      //         child: const Center(
      //           child: TextFontWidgetRouter(
      //             text: "Update",
      //             fontsize: 14,
      //             // fontWeight: FontWeight.w600,
      //             color: cWhite,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ],doyouwantActionButton: true,
    actiononTapfuction: ()async {
   await   meetingController.updateMeeting(
        data.meetingId, context);
        print("okaaaaaaaaaa");
             print(data.meetingId);
    },
    
    actiontext: 'Update',
  );
}

deleteFunctionOfMeetings(BuildContext context, MeetingModel data) {
  final MeetingController meetingController = Get.put(MeetingController());
  customDeleteShowDialog(
    context: context,
    onTap: () {
      meetingController.deleteMeeting(data.meetingId, context);
    },
  );

  // customShowDilogBox(
  //     context: context,
  //     title: 'Delete',
  //     children: [
  //       GooglePoppinsWidgets(
  //           text: 'Are you sure to want delete',
  //           fontsize: ResponsiveWebSite.isMobile(context) ? 12 : 15)
  //     ],actiononTapfuction: () {
  //       meetingController.deleteMeeting(data.meetingId, context);
  //     },
  //     doyouwantActionButton: true);
}

allviewFunctionOfMeeting(BuildContext context, MeetingModel data) {
  customShowDilogBox(
      context: context,
      title: 'Meeting',
      children: [
        SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Topic",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(text: data.topic, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Time",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(text: data.time, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Date",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(text: data.date, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Category",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child:
                            TextFontWidget(text: data.category, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Venue",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(text: data.venue, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "  Expected Members",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(text: data.members, fontsize: 13),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextFontWidget(
                    text: "   Special Guest",
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                      width: ResponsiveWebSite.isMobile(context) ? 250 : 500,
                      height: 35,
                      color: cBlue.withOpacity(0.1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFontWidget(
                            text: data.specialGuest, fontsize: 13),
                      )),
                ],
              ),
              //  TextFontWidget(text: data.time, fontsize: 13),
              //  TextFontWidget(text: data.date, fontsize: 13),
              // TextFontWidget(text: data.category, fontsize: 13),
              // TextFontWidget(text: data.venue, fontsize: 13),
              // TextFontWidget(text: data.members, fontsize: 13),
              // TextFontWidget(text: data.specialGuest, fontsize: 13),
            ],
          ),
        )
      ],
      doyouwantActionButton: false);
}
