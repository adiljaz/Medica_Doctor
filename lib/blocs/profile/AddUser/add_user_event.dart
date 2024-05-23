part of 'add_user_bloc.dart';

@immutable
sealed class AddUserEvent {}

class AddUserClick extends AddUserEvent {
  final String name;
  final int age;
  final String dob;
  final String imageUrl;
  final String gender;
  final String location;
  final int mobile;
  final String department;
  final int experiance;
  final String form;
  final String to;
  final List<bool>? availabledays;
  final String hospitalNAme;
  final int fees;
  final String? about;
  final String certificates;

  AddUserClick({
    required this.name,
    required this.age,
    required this.dob,
    required this.imageUrl,
    required this.gender,
    required this.location,
    required this.mobile,
    required this.department,
    required this.experiance,
    required this.form,
    required this.to,
    required this.hospitalNAme,
    required this.fees,
    required this.certificates,
    this.about,
    this.availabledays,
  });
}
