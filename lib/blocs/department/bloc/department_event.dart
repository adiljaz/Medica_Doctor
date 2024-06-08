part of 'department_bloc.dart';

@immutable
sealed class DepartmentEvent {}

class DepartmenetSelected extends DepartmentEvent{
  final String selecteDepartment;

  DepartmenetSelected({required this.selecteDepartment});
}
