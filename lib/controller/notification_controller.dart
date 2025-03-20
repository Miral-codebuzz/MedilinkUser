import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notiifcationData = [
    NotificationModel(
      dateAndTime: '22 feb 2025',
      time: '8:19 pm',
      title: 'Appointment Confirmation',
      subTitle:
          'Sent after booking an appointment to confirm details like date, time, and doctor',
      imageIcon: AppImage.notificationIcon,
      onTap: () {},
    ),
  ];
}

class NotificationModel {
  final String dateAndTime;
  final String time;
  final String title;
  final String subTitle;
  final String imageIcon;
  final void Function()? onTap;

  NotificationModel({
    required this.dateAndTime,
    required this.time,
    required this.title,
    required this.subTitle,
    required this.imageIcon,
    this.onTap,
  });
}
