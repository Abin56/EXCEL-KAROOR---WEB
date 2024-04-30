import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidyaveechi_website/controller/image_upload_controller/image_uploader_controller.dart';
import 'package:vidyaveechi_website/controller/user_login_Controller/user_login_controller.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/text_widget.dart';
import 'package:vidyaveechi_website/view/utils/firebase/firebase.dart';
import 'package:vidyaveechi_website/view/utils/shared_pref/user_auth/user_credentials.dart';
import 'package:vidyaveechi_website/view/widgets/blue_Container_widget/blue_Container_widget.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';
import 'package:vidyaveechi_website/view/widgets/textformFiledContainer/textformFiledBlueContainer.dart';

@override
adminProfileshowlist(BuildContext context) {
  // Rxn<Uint8List> image = Rxn();
  final profileCtr = Get.put(AdminProfileController());

  aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    backgroundColor: cWhite,
    header: Container(),
    showActions: false,
    footer: Container(),
    body: ResponsiveWebSite.isMobile(context)
        ? SingleChildScrollView(
            child: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(),
                     TextFontWidget(
                      text: "Profile",
                      fontsize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () async {
                            if (kDebugMode) {
                              print("logoutUser");
                            }
                            await Get.find<UserLoginController>()
                                .logoutSaveData()
                                .then((value) => logoutUser());
                            logoutUser();
                          },
                          icon: const Icon(Icons.power_settings_new_sharp)),
                    )
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: profileCtr.onTapEdit.value == true
                        ? GestureDetector(
                            onTap: () {
                              profileCtr.onTapEdit.value = false;
                            },
                            child: BlueContainerWidget(
                                title: "Cancel",
                                fontSize: ResponsiveWebSite.isMobile(context)
                                    ? 14
                                    : 16,
                                color: cBlue,
                                width: 80),
                          )
                        : GestureDetector(
                            onTap: () {
                              profileCtr.onTapEdit.value = true;
                            },
                            child: BlueContainerWidget(
                                title: "Edit",
                                fontSize: ResponsiveWebSite.isMobile(context)
                                    ? 14
                                    : 16,
                                color: cBlue,
                                width: 80),
                          ),
                  ),
                ),
                Obx(
                  () => profileCtr.onTapEdit.value == true
                      ? AdminProfileEdit()
                      : AdminProfileWidgetOne(),
                )
              ],
            )),
          )
        : SingleChildScrollView(
            child: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(),
                     TextFontWidget(
                      text: "Profile",
                      fontsize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () async {
                            if (kDebugMode) {
                              print("logoutUser");
                            }
                            await Get.find<UserLoginController>()
                                .logoutSaveData()
                                .then((value) => logoutUser());
                            logoutUser();
                          },
                          icon: const Icon(Icons.power_settings_new_sharp)),
                    )
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: profileCtr.onTapEdit.value == true
                        ? GestureDetector(
                            onTap: () {
                              profileCtr.onTapEdit.value = false;
                            },
                            child: BlueContainerWidget(
                                title: "Cancel",
                                fontSize: ResponsiveWebSite.isMobile(context)
                                    ? 14
                                    : 16,
                                color: cBlue,
                                width: 80),
                          )
                        : GestureDetector(
                            onTap: () {
                              profileCtr.onTapEdit.value = true;
                            },
                            child: BlueContainerWidget(
                                title: "Edit",
                                fontSize: ResponsiveWebSite.isMobile(context)
                                    ? 14
                                    : 16,
                                color: cBlue,
                                width: 80),
                          ),
                  ),
                ),
                Obx(
                  () => profileCtr.onTapEdit.value == true
                      ? AdminProfileEdit()
                      : AdminProfileWidgetOne(),
                )
              ],
            )),
          ),
  );
}

class AdminProfileEdit extends StatelessWidget {
  AdminProfileEdit({super.key});

  final imageCtr = Get.put(ImageController());
  final profileCtr = Get.put(AdminProfileController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: ResponsiveWebSite.isMobile(context) ? 50 : 70,
                  backgroundColor: cred,
                  // backgroundImage: NetworkImage(profileCtr.image.value),
                  child: Image.asset('webassets/png/avathar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 60),
                child: Center(
                  child: CircleAvatar(
                    radius: ResponsiveWebSite.isMobile(context) ? 12 : 15,
                    backgroundColor: Colors.cyanAccent,
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 65, left: 90),
                child: GestureDetector(
                  onTap: () async {
                    imageCtr.pickImage();
                  },
                  child: Icon(
                    Icons.edit_square,
                    size: ResponsiveWebSite.isMobile(context) ? 15 : 18,
                  ),
                ),
              )),
            ],
          ),
          TextFormFiledBlueContainerWidgetWithOutColor(
              controller: profileCtr.nameController,
              hintText: ' Enter your name',
              title: 'Name'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              controller: profileCtr.designationController,
              hintText: ' Designation',
              title: 'Designation'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              controller: profileCtr.aboutController,
              hintText: ' About',
              title: 'About'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              controller: profileCtr.phoneController,
              hintText: ' phone no.',
              title: 'phone no.'),
          TextFormFiledBlueContainerWidgetWithOutColor(
              controller: profileCtr.emailController,
              hintText: ' Email',
              title: 'Email'),
           TextFontWidget(text: 'Gender *', fontsize: 12.5),
          const SizedBox(height: 5),
          Container(
            color: screenContainerbackgroundColor,
            child: DropdownSearch(
              selectedItem: profileCtr.gender.value,
              onSaved: (newValue) {
                profileCtr.gender.value = newValue!;
              },
              onChanged: (value) {
                profileCtr.gender.value = value!;
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      hintText: " Please Select Gender",
                      labelStyle: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 13 : 15,
                      ),
                      contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                      prefixIcon: const Icon(
                        Icons.person_2,
                        size: 20,
                      ))),
              items: const ['Male', 'Female', 'Others'],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                profileCtr.updateAdminProfile();
              },
              child: BlueContainerWidget(
                  title: "Save",
                  fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                  color: cBlue,
                  width: 80),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminProfileWidgetOne extends StatelessWidget {
  AdminProfileWidgetOne({
    super.key,
  });
  final profileCtr = Get.put(AdminProfileController());

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(serverAuth.currentUser!.uid);
    return StreamBuilder(
        stream: docRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!;
            profileCtr.nameController.text = data['adminUserName'];
            profileCtr.designationController.text = data['designation'];
            profileCtr.aboutController.text = data['about'];
            profileCtr.phoneController.text = data['phoneNumber'];
            profileCtr.emailController.text = data['email'];
            profileCtr.gender.value = data['gender'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: CircleAvatar(
                          radius: ResponsiveWebSite.isMobile(context) ? 50 : 70,
                          backgroundColor: cred,
                          backgroundImage: NetworkImage(data['image']),
                        ),
                      ),
                    ),
                  ],
                ),
                ////////////////////////////////........................0
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                      child: Text(
                    data['adminUserName'],
                    style: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 15 : 18,
                        fontWeight: FontWeight.bold),
                  )),
                ), ///////////////////////////////............1
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                      child: Text(
                    data['designation'],
                    // 'Designation',
                    style: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                        fontWeight: FontWeight.bold),
                  )),
                ), /////////////////////////..............2
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "About",
                    style: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 17,
                        fontWeight: FontWeight.bold),
                  ),
                ), /////////////////////////.....................3
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    data['about'],
                    // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 12 : 15,
                        fontWeight: FontWeight.bold),
                  ),
                ), ////////////////////////..................4
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "Contacts",
                    style: TextStyle(
                        fontSize: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //////////////////////////////................5
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.phone_iphone,
                          size: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          data['phoneNumber'],
                          // '46545645665465',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveWebSite.isMobile(context) ? 14 : 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ///////////////////////////////............................6
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.email,
                          size: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          data['email'],
                          //  'lepton@gmail.com',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveWebSite.isMobile(context) ? 14 : 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ////////////////////////////////////////.............................7

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Icon(
                          Icons.person,
                          size: ResponsiveWebSite.isMobile(context) ? 14 : 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          data['gender'],
                          // 'Gender',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveWebSite.isMobile(context) ? 14 : 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text("No data available");
          }
        });
  }
}
