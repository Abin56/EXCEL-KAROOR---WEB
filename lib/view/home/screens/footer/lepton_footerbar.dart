import 'package:flutter/material.dart';
import 'package:vidyaveechi_website/view/colors/colors.dart';
import 'package:vidyaveechi_website/view/fonts/google_poppins_widget.dart';
import 'package:vidyaveechi_website/view/widgets/responsive/responsive.dart';

class LeptonFooterBar extends StatelessWidget {
  const LeptonFooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlue[800]),
      height: ResponsiveWebSite.isMobile(context) ? 300 : 200,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: ResponsiveWebSite.isMobile(context) ? 300 : 200,
            width: double.infinity,
            child: ResponsiveWebSite.isMobile(context)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('webassets/images/leptonlogo.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        // color: Colors.red,
                        height: 190,
                        width: 350,
                        child: Center(
                          child: GooglePoppinsWidgets(
                              color: cWhite,
                              text:
                                  'Lepton Plus Communications is a customer oriented company offering digital solutions in Healthcare,E-Commerce Applications\nHome Automation and Social Networking.\nWe are commited to providing high end sustainable products and services that\nenhances the quality of life',
                              fontsize: 12),
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('webassets/images/leptonlogo.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: SizedBox(
                            height: 150,
                            child: Center(
                              child: GooglePoppinsWidgets(
                                  color: cWhite,
                                  text:
                                      'Lepton Plus Communications is a customer oriented company offering digital solutions in Healthcare,E-Commerce Applications\nHome Automation and Social Networking.\nWe are commited to providing high end sustainable products and services that\nenhances the quality of life',
                                  fontsize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
