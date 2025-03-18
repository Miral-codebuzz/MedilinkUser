import 'dart:ffi';

import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/widgets/app_bar_widget.dart';
import 'package:doc_o_doctor/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarWidget(title: AppString.termsAndCondition),
                SizedBox(height: 30),
                termsConditionWidget(
                  title: '*Acceptable of Terms',
                  subTitle:
                      'By using this app, you agree to these Terms & Conditions. If you do not agree, please do not use the service',
                ),
                termsConditionWidget(
                  title: '*Appointment Booking',
                  subTitle:
                      'Users can book, reschedule, or cancel appointments through the app. Appointment availability is subject to the doctor’s schedule. Late cancellations or missed appointments may incure fees.',
                ),
                termsConditionWidget(
                  title: '*User Responsibilities',
                  subTitle:
                      'Provide accurate personal and medical information. Arrive on time for scheduled appointments. Follow the doctor’s instructions and medical advice responsibly.',
                ),
                termsConditionWidget(
                  title: '*Privacy & Data Protection',
                  subTitle:
                      'User data is stored securely and shared only with authorized healthcare providers.  The app complies with relevant data protection laws.',
                ),
                termsConditionWidget(
                  title: '*Limitation of liability',
                  subTitle:
                      'The apps acts as a booking platform and is not responsible for medical advise or treatments outcomes. Users should consult licensed healthcare professionals for medical concerns.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget termsConditionWidget({required String title, required String subTitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CustomText(
        text: title,
        fontSize: 16,
        textAlignment: TextAlign.start,
        fontWeight: FontWeight.w500,
        textColor: AppColor.textGrey,
      ),
      SizedBox(height: 10),
      Text(
        subTitle,
        style: TextStyle(
          color: AppColor.textGrey.withValues(alpha: 0.6),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
      ),
      SizedBox(height: 10),
      Divider(thickness: 3, color: AppColor.lightGrey),
      SizedBox(height: 10),
    ],
  );
}
