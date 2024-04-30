import 'package:flutter/material.dart';
import 'package:sidebar_drawer/sidebar_drawer.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/constantvalidate.dart';
import 'package:vidyaveechi_website/view/fonts/google_poppins_widget.dart';
import 'package:vidyaveechi_website/view/users/admin/admin_home.dart';
// import 'package:vidyaveechi_website/view/users/admin/drawer/drawer_pages.dart';
import 'package:vidyaveechi_website/view/users/teacher/app_bar/teacher_appBar.dart';
import 'package:vidyaveechi_website/view/users/teacher/drawer/teacher_drawer_pages.dart';
// import 'package:vidyaveechi_website/view/users/teacher/widget/teacherwidget.dart';

class TeachersHomeScreen extends StatefulWidget {
  const TeachersHomeScreen({super.key});

  @override
  State<TeachersHomeScreen> createState() => _TeachersHomeScreenState();
}

class _TeachersHomeScreenState extends State<TeachersHomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: SidebarDrawer(
            body: ListView(
              children: [
                AppBarTeacherPanel(),
                pages[selectedIndex],
              ],
            ),
            drawer: Container(
              color: cWhite,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Image.asset(
                                'webassets/excel_karror/excel_karoor_logo.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            GooglePoppinsWidgets(
                              text: "EXCEL KAROOR",
                              fontsize: 20,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 12),
                        child: Text(
                          "Main Menu",
                          style: TextStyle(
                              color: cBlack.withOpacity(
                                0.4,
                              ),
                              fontSize: 12),
                        ),
                      ),
                      sHeight10,
                      DrawerSelectedPagesSectionOfTeacher(
                        selectedIndex: selectedIndex,
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

// List<Widget> pages = [
//  const TeacherDashBoardScreen(),
//   Center(
//     child: Text(sideMenu[1]),
//   ),
//   Center(
//     child: Text(sideMenu[2]),
//   ),
//   Center(
//     child: Text(sideMenu[3]),
//   ),
//   Center(
//     child: Text(sideMenu[4]),
//   ),
//   Center(
//     child: Text(sideMenu[5]),
//   ),
//   Center(
//     child: Text(sideMenu[6]),
//   ),
//   Center(
//     child: Text(sideMenu[7]),
//   ),
//   Center(
//     child: Text(sideMenu[8]),
//   ),
//   Center(
//     child: Text(sideMenu[9]),
//   ),
//   Center(
//     child: Text(sideMenu[10]),
//   ),
//   Center(
//     child: Text(sideMenu[11]),
//   ),
// ];
// List<String> sideMenu = [
//   'Attendence',
//   'Food Manage',
//   'Rooms Manage',
//   'Leave Requests',
//   'Visitors Pass',
//   'Students Manage',
//   'Students Payment',
//   'Employee Manage',
//   'Bill Manage',
//   'Notice Board',
//   'Settings',
//   'Rules',
// ];
