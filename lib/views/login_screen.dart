import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/business_logic/auth_cubit/auth_cubit.dart';
import 'package:task_manager_app/business_logic/auth_cubit/auth_states.dart';
import 'package:task_manager_app/views/task_manager_view.dart';
import 'package:task_manager_app/views/widgets/custom_text_field.dart';
import 'package:task_manager_app/views/widgets/responsive_ui/responsive_widget.dart';

import 'widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
      responsive: (context, deviceInfo) =>
        BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
      if(state is AuthSuccess){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>  const TaskManagerView())
            , (route) => false);
      }
    },
    builder: (context, state) {
              return Scaffold(
              body: Center(
              child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
              key: formKey,
              autovalidateMode: autoValidateMode,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
              controller: emailController,
              hint: 'enter your email',
              ),
                SizedBox(
              height: 16.h,
              ),
                CustomTextField(
              controller: passController,
              isPassword:  AuthCubit.get(context).isVisible == true? false:true,
              suffix: IconButton(
              onPressed: (){
    AuthCubit.get(context).visibilityPasswordChange();
    },
    icon: AuthCubit.get(context).isVisible ==true?
    const Icon(Icons.visibility,
    color: Colors.white,
    size: 30,
    )
        :const Icon(Icons.visibility_off_outlined,
    color: Colors.white,
    size: 30,
    ),
    ),
    hint: 'enter your password',
    ),
                SizedBox(
    height: 32.h,
    ),
                CustomButton(
                  isLoading: state is AuthLoading ? true : false,
                  isLogin: true,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      BlocProvider.of<AuthCubit>(context).login(
                        username: emailController.text,
                        password: passController.text,
                      );
                    } else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),

                ],
    ),
    ),
    ),
    ),
    );
    }

    ),
        ),

        );
  }
}
