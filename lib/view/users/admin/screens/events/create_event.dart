import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/event_controller/event_controller.dart';
import 'package:vidyaveechi_website/view/constant/constant.validate.dart';
import 'package:vidyaveechi_website/view/widgets/progess_button/progress_button.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';
import 'package:vidyaveechi_website/view/widgets/routeSelectedTextContainer/routeSelectedTextContainer.dart';
import 'package:vidyaveechi_website/view/widgets/textformFiledContainer/textformFiledBlueContainer.dart';

class CreateEvent extends StatelessWidget {
  final EventController eventController = Get.put(EventController());
  CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    //  List<Widget> textformWidget = [
    // Padding(
    //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
    //   child: TextFormFiledBlueContainerWidget(
    //     width: ResponsiveWebSite.isMobile(context) ? double.infinity : 500,
    //     validator: checkFieldEmpty,
    //     controller: eventController.eventnameController,
    //     title: 'Event Name',
    //     hintText: 'Event Name', /////////////////////////////////////////0
    //   ),
    // ),

    // Padding(
    //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
    //   child: TextFormFiledBlueContainerWidgetAchievement(
    //     width: ResponsiveWebSite.isMobile(context) ? double.infinity : 500,
    //     validator: checkFieldDateIsValid,
    //     controller: eventController.eventdateController,
    //     hintText: 'Date',
    //     title: 'Date',
    //   ),
    // ), ////////////////////////////////////////////////////////1
    // Padding(
    //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
    //   child: TextFormFiledBlueContainerWidgetAchievement(
    //     width: ResponsiveWebSite.isMobile(context) ? double.infinity : 500,
    //     validator: checkFieldEmpty,
    //     controller: eventController.eventvenueController,
    //     title: 'Venue',
    //     hintText: 'Venue',
    //   ),
    // ), ///////////////////////////////////////////////2
    // Padding(
    //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
    //   child: TextFormFiledBlueContainerWidgetAchievement(
    //     width: ResponsiveWebSite.isMobile(context) ? double.infinity : 500,
    //     validator: checkFieldEmpty,
    //     controller: eventController.eventdescriptionController,
    //     title: 'Description',
    //     hintText: 'Description',
    //   ),
    // ), ////////////////////////////////////3
    // Padding(
    //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
    //   child: TextFormFiledBlueContainerWidgetAchievement(
    //     width: ResponsiveWebSite.isMobile(context) ? double.infinity : 500,
    //     validator: checkFieldEmpty,
    //     controller: eventController.eventsignedByController,
    //     title: 'Signed by',
    //     hintText: 'Signed by',
    //   ),
    // ), ////////////////////////////////////4

    //   const Expanded(
    //       child: SizedBox(
    //     height: 40,
    //     width: 400,
    //   ))
    // ];
    return Container(
      child: Form(
        key: eventController.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        {
                          aweSideSheet(
                              context: context,
                              sheetPosition: SheetPosition.right,
                              title: "Events",
                              body: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 800,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child:
                                                //  Obx(() {
                                                // return
                                             Form(
                                              key: eventController.formKey,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10),
                                                      child:
                                                          TextFormFiledHeightnoColor(
                                                        width: ResponsiveWebSite
                                                                .isMobile(
                                                                    context)
                                                            ? double.infinity
                                                            : 500,
                                                        validator:
                                                            checkFieldEmpty,
                                                        controller: eventController
                                                            .eventnameController,
                                                        title: 'Event Name',
                                                        hintText:
                                                            'Event Name', /////////////////////////////////////////0
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10),
                                                      child:
                                                          TextFormFiledHeightnoColor(
                                                        onTap: () {
                                                          eventController.selectDate(
                                                              context,
                                                              eventController
                                                                  .eventdateController);
                                                        },
                                                        width: ResponsiveWebSite
                                                                .isMobile(
                                                                    context)
                                                            ? double.infinity
                                                            : 500,
                                                        validator:
                                                            checkFieldEmpty,
                                                        controller: eventController
                                                            .eventdateController,
                                                        title: 'Date',
                                                        hintText: 'Date',
                                                      ),
                                                    ), ////////////////////////////////////////////////////////1
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10),
                                                      child:
                                                          TextFormFiledHeightnoColor(
                                                        width: ResponsiveWebSite
                                                                .isMobile(
                                                                    context)
                                                            ? double.infinity
                                                            : 500,
                                                        validator:
                                                            checkFieldEmpty,
                                                        controller: eventController
                                                            .eventvenueController,
                                                        title: 'Venue',
                                                        hintText: 'Venue',
                                                      ),
                                                    ), ///////////////////////////////////////////////2
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10),
                                                      child:
                                                          TextFormFiledHeightnoColor(
                                                        width: ResponsiveWebSite
                                                                .isMobile(
                                                                    context)
                                                            ? double.infinity
                                                            : 500,
                                                        validator:
                                                            checkFieldEmpty,
                                                        controller: eventController
                                                            .eventdescriptionController,
                                                        title: 'Description',
                                                        hintText: 'Description',
                                                      ),
                                                    ), ////////////////////////////////////3
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10),
                                                      child:
                                                          TextFormFiledHeightnoColor(
                                                        width: ResponsiveWebSite
                                                                .isMobile(
                                                                    context)
                                                            ? double.infinity
                                                            : 500,
                                                        validator:
                                                            checkFieldEmpty,
                                                        controller: eventController
                                                            .eventsignedByController,
                                                        title: 'Signed by',
                                                        hintText: 'Signed by',
                                                      ),
                                                    ), ////////////////////////////////////4

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 25,
                                                              bottom: 10),
                                                      child: Center(
                                                          child: Obx(() =>
                                                              ProgressButtonWidget(
                                                                  function:
                                                                      () async {
                                                                    if (eventController
                                                                        .formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      eventController
                                                                          .createEvent();
                                                                      print(
                                                                          "object");
                                                                    }
                                                                  },
                                                                  buttonstate:
                                                                      eventController
                                                                          .buttonstate
                                                                          .value,
                                                                  text:
                                                                      'Create Event'))
                                                          //     NoticeButtonContainerWidget(
                                                          //   text: 'Submit',
                                                          //   width: 300,
                                                          //   height: 50,
                                                          //   fontSize: 18,
                                                          //   onTap: () {},
                                                          //   color: AppColors
                                                          //       .darkBlueColor,
                                                          // ),
                                                          ),
                                                    )
                                                    // }),
                                                  ]),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              showCloseButton: false,
                              footer: Container());
                        }
                      },
                      child: const RouteSelectedTextContainer(
                          width: 140, title: 'Create')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
