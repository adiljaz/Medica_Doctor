part of 'department_bloc.dart';

@immutable
sealed class DepartmentState {}

final class DepartmentInitial extends DepartmentState {}

class DepartmenetSelectedState extends DepartmentState {
  final String selectedDepartment;

  DepartmenetSelectedState({required this.selectedDepartment});
}
