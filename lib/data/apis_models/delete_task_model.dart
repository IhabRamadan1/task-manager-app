class DeleteNewTaskModel {
  int? id;
  String? todo;
  bool? completed;
  int? userId;
  bool? isDeleted;

  DeleteNewTaskModel(
      {this.id, this.todo, this.completed, this.userId, this.isDeleted});

  DeleteNewTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
