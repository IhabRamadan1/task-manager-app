import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/services/task_validator.dart';

void main() {
  group('Input Validation', () {
    test('Valid Task Title', () {
      var result = TaskValidator.validateTitle('Valid Title');
      expect(result, null);
    });

    test('Invalid Task Title', () {
      var result = TaskValidator.validateTitle('');
      expect(result, 'Title cannot be empty');
    });

    test('Valid Task Description', () {
      var result = TaskValidator.validateDescription('Valid Description');
      expect(result, null);
    });

    test('Invalid Task Description', () {
      var result = TaskValidator.validateDescription('');
      expect(result, 'Description cannot be empty');
    });
  });
}
