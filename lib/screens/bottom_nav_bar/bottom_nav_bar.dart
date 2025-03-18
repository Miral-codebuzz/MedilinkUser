import 'package:doc_o_doctor/constants/app_color.dart';
import 'package:doc_o_doctor/constants/app_images.dart';
import 'package:doc_o_doctor/constants/app_string.dart';
import 'package:doc_o_doctor/constants/text_style_decoration.dart';
import 'package:doc_o_doctor/controller/bottom_bar_controller.dart';
import 'package:doc_o_doctor/screens/booking_screen/booking_screen.dart';
import 'package:doc_o_doctor/screens/home_screen/home_screen.dart';
import 'package:doc_o_doctor/screens/login_screen/login_screen.dart';
import 'package:doc_o_doctor/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBarController controller = Get.put(BottomNavBarController());
    // Screens for each tab
    final List<Widget> screens = [
      Center(child: LoginScreen()),
      Center(child: BookingScreen()),
      Center(child: SettingsScreen()),
    ];

    // Function to build navigation bar items with dynamic color change
    BottomNavigationBarItem _buildNavItem({
      required String imagePath,
      required String label,
      required int index,
    }) {
      return BottomNavigationBarItem(
        icon: Obx(() {
          bool isSelected = controller.selectedIndex.value == index;
          return ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelected ? AppColor.primaryColor : AppColor.grey,
              BlendMode.srcIn,
            ),
            child: Image.asset(imagePath, width: 24, height: 24),
          );
        }),
        label: label,
      );
    }

    return Scaffold(
      body: Obx(
        () => screens[controller.selectedIndex.value],
      ), // Observe index changes
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedLabelStyle: TextStyleDecoration.labelMedium.copyWith(
            color: AppColor.primaryColor,
            fontSize: 10,
          ),
          unselectedLabelStyle: TextStyleDecoration.labelMedium.copyWith(
            color: AppColor.grey,
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          items: [
            _buildNavItem(
              imagePath: AppImage.homeIcon,
              label: AppString.home,
              index: 0,
            ),
            _buildNavItem(
              imagePath: AppImage.bookingIcon,
              label: AppString.booking,
              index: 1,
            ),
            _buildNavItem(
              imagePath: AppImage.settingIcon,
              label: AppString.setting,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}
