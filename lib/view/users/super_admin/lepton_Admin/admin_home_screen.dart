import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyaveechi_website/view/users/super_admin/lepton_Admin/requested_list/req_list_screen.dart';

import '../widgets/buttonContainer.dart';
import 'list_of_schools/list_of_schools_screen.dart';

class LeptonHomePage extends StatelessWidget {
  const LeptonHomePage({super.key});
  static const String route = '/homePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                            Get.off(const SchoolsListScreen());
         
              },
              child: ButtonContainerWidget(
                curving: 30,
                colorindex: 0,
                height: 200,
                width: 400,
                child: Center(
                    child: Text(
                  'List of Schools',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
             Get.off(RequestedSchoolsListScreen());
              },
              child: ButtonContainerWidget(
                curving: 30,
                colorindex: 6,
                height: 200,
                width: 400,
                child: Center(
                    child: Text(
                  'Requested List',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
