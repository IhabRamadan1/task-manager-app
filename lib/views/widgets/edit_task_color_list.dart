import 'package:flutter/material.dart';
import 'package:task_manager_app/data/task_manager_model.dart';

import '../../core/constants/constants.dart';
import 'colors_list_view.dart';

class EditTaskColorsList extends StatefulWidget {
  const EditTaskColorsList({super.key, required this.task});

  final TaskModel task;
  @override
  State<EditTaskColorsList> createState() => _EditTaskColorsListState();
}

class _EditTaskColorsListState extends State<EditTaskColorsList> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = kColors.indexOf(Color(widget.task.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
        itemCount: kColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                currentIndex = index;
                widget.task.color = kColors[index].value;
                setState(() {});
              },
              child: ColorItem(
                color: kColors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}