import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<NotificationModel> NotiifcationData = [
    NotificationModel(
      date: '22 feb 2025',
      time: '8:19 pm',
      title: 'Appointment Confirmation',
      subTitle:
          'Sent after booking an appointment to confirm details like date, time, and doctor',
      imageIcon: AppImage.notificationIcon,
    ),
  ];
}

class NotificationModel {
  final String date;
  final String time;
  final String title;
  final String subTitle;
  final String imageIcon;

  NotificationModel({
    required this.date,
    required this.time,
    required this.title,
    required this.subTitle,
    required this.imageIcon,
  });
}
