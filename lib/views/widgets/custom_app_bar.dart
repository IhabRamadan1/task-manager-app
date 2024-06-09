import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/views/widgets/responsive_ui/responsive_widget.dart';

import 'custom_icon.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key, required this.title, required this.icon, this.onPressed})
      : super(key: key);

  final String title;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
        responsive: (context, deviceInfo) =>
   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:  TextStyle(
              fontSize: 22.sp,
            ),
          ),
          CustomIcon(
            onPressed: onPressed,
            icon: icon,
          ),
        ],
      ),
    );
  }
}