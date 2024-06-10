class TaskValidator {
  static String? validateTitle(String title) {
    if (title.isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }

  static String? validateDescription(String description) {
    if (description.isEmpty) {
      return 'Description cannot be empty';
    }
    return null;
  }
}
