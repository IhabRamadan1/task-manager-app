import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/business_logic/tasks_cubit/tasks_states.dart';

import '../../constants.dart';


class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  // List<NoteModel>? notes;
  // fetchAllNotes() {
  //   var notesBox = Hive.box<NoteModel>(kNotesBox);
  //
  //   notes = notesBox.values.toList();
  //   emit(NotesSuccess());
  // }
}