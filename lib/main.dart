import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_manager_app/core/network_services/local/shared_preferences.dart';
import 'package:task_manager_app/views/login_screen.dart';
import 'business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'core/bloc_observer.dart';
import 'business_logic/tasks_cubit/tasks_cubit.dart';
import 'core/constants/constants.dart';
import 'core/network_services/remote/dio_helper.dart';
import 'views/task_manager_view.dart';
import 'data/task_manager_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(kTaskBox);
  token = CacheHelper.getData(key: "token");
  Widget? startWidget;

  if (token != null) {
    startWidget = const TaskManagerView();
  } else {
    startWidget =const LoginScreen();
  }
  runApp( MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TasksCubit(),),
          BlocProvider(
            create: (context) => TaskApiCubit(),),
        ],

      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
          home:  startWidget,
        ),
      ),
    );
  }
}

