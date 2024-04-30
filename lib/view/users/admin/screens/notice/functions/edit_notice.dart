import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/notice_controller/notice_controller.dart';
import 'package:vidyaveechi_website/model/notice_model/notice_model.dart';
import 'package:vidyaveechi_website/view/users/admin/screens/events/events.dart';
import 'package:vidyaveechi_website/view/widgets/custom_showdialouge/custom_showdialouge.dart';

editFunctionOfNotice(BuildContext context, NoticeModel data) {
  final NoticeController noticeController = Get.put(NoticeController());
  customShowDilogBox(
      context: context,
      title: 'Edit',
      children: [
        TextFormFiledBlueContainerWidgetEvent(
          controller: noticeController.noticeHeadingController,
            hintText: data.heading, title: 'Heading'),
        TextFormFiledBlueContainerWidgetEvent(
          onTap: () {
            noticeController.selectDate(context, noticeController.editnoticePublishedDateController,);
          },
          controller: noticeController.editnoticePublishedDateController,
            hintText: data.publishedDate, title: 'Published Date'),
        TextFormFiledBlueContainerWidgetEvent(
           controller: noticeController.noticeSubjectController,
            hintText: data.subject, title: 'Subject'),
        TextFormFiledBlueContainerWidgetEvent(
           onTap: () {
            noticeController.selectDate(context, noticeController.editnoticeDateofoccationController,);
          },
          controller: noticeController.editnoticeDateofoccationController,
            hintText: data.dateofoccation, title: 'Date Of Occation'),
        TextFormFiledBlueContainerWidgetEvent(
           controller: noticeController.noticevenueController,
            hintText: data.venue, title: 'Venue'),
        TextFormFiledBlueContainerWidgetEvent(
           onTap: () {
            noticeController.selectDate(context, noticeController.editnoticeDateofSubmissionController,);
          },
          controller: noticeController.editnoticeDateofSubmissionController,
            hintText: data.dateOfSubmission, title: 'Date Of Submission'),
        TextFormFiledBlueContainerWidgetEvent(
           controller: noticeController.noticeGuestController,
            hintText: data.chiefGuest, title: 'Cheif guest'),
        TextFormFiledBlueContainerWidgetEvent(
           controller: noticeController.noticeSignedByController,
            hintText: data.signedBy, title: 'Signed by'),
      ],
      doyouwantActionButton: true,
      actiononTapfuction: () {
        noticeController.updateNotice(
          data.noticeId,
          context,
        );
        print('idddddddddddddddddddddddddddddddddddddddd${data.noticeId}');
      },
      actiontext: 'Update');
}
