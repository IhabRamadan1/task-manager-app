
abstract class TaskApiState {}

class TaskInitial extends TaskApiState {}

class GetTasksLoading extends TaskApiState {}

class GetTasksSuccess extends TaskApiState {}

class GetTasksFailure extends TaskApiState {
  final String error;

  GetTasksFailure(this.error);
}

class AddTaskLoading extends TaskApiState {}

class AddTaskSuccess extends TaskApiState {}

class AddTaskFailure extends TaskApiState {
  final String error;

  AddTaskFailure(this.error);
}

class EditTaskLoading extends TaskApiState {}

class EditTaskSuccess extends TaskApiState {}

class EditTaskFailure extends TaskApiState {
  final String error;

  EditTaskFailure(this.error);
}

class DeleteTaskLoading extends TaskApiState {}

class DeleteTaskSuccess extends TaskApiState {}

class DeleteTaskFailure extends TaskApiState {
  final String error;

  DeleteTaskFailure(this.error);
}


class AddTaskLocallyInitial extends TaskApiState {}

class AddTaskLocallyLoading extends TaskApiState {}

class AddTaskLocallySuccess extends TaskApiState {}

class AddTaskLocallyFailure extends TaskApiState {
  final String errMessage;

  AddTaskLocallyFailure(this.errMessage);
}

class FetchTaskSuccess extends TaskApiState{}