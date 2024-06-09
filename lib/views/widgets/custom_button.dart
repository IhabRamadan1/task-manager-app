import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/views/widgets/responsive_ui/responsive_widget.dart';

import '../../core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.isLoading = false,
    this.isLogin =false
  });

  final void Function()? onTap;
  final bool isLogin;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
      responsive: (context, deviceInfo) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55.h,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(
                8,
              )),
          child: Center(
            child: isLoading
                ?  SizedBox(
              height: 24.h,
              width: 24.w,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            )
                :  Text(
              isLogin == false?
              'Add': 'Login',
              style:  TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}