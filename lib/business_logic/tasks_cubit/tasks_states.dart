
abstract class TasksState {}

class TaskInitial extends TasksState {}
class TaskSuccess extends TasksState {}
class GetTasksLoading extends TasksState {}
class GetTasksSuccess extends TasksState {}
class GetTasksFailure extends TasksState {
  String e;
  GetTasksFailure(this.e);
}
