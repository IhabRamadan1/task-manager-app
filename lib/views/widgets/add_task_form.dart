import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_cubit.dart';
import 'package:task_manager_app/business_logic/tasks_apis_cubit/tasks_api_states.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import 'colors_list_view.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: 'title',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hint: 'content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 32,
          ),
          const ColorsListView(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<TaskApiCubit, TaskApiState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddTaskLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var currentDate = DateTime.now();

                    var formattedCurrentDate =
                    DateFormat('dd-mm-yyyy').format(currentDate);
                    var taskModel = TaskModel(
                        title: title!,
                        subTitle: subTitle!,
                        date: formattedCurrentDate,
                        color: Colors.blue.value);
                    BlocProvider.of<TaskApiCubit>(context).addTaskApi(title!);
                    BlocProvider.of<TaskApiCubit>(context).addTaskLocally(taskModel);

                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}