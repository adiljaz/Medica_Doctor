import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AddUserBloc() : super(AddUserInitial()) {
    on<AddUserClick>((event, emit) async {
      emit(AddUserLOadingState());
      String? uid = _auth.currentUser?.uid;

      final result = await _addData(
        name: event.name,
        age: event.age,
        dob: event.dob,
        gender: event.gender,
        imageUrl: event.imageUrl,
        location: event.location,
        mobile: event.mobile,
        uid: uid,
        certificates: event.certificates,
        department: event.department,
        experiance: event.experiance,
        fees: event.fees,
        form: event.form,
        hospitalNAme: event.hospitalNAme,
        to: event.to,
        about: event.about,
        availabledays: event.availabledays,
      );

      if (result) {
        emit(AddUserSuccesState());
      } else {
        emit(AddUserErrorState('Failed to add data.'));
      }
    });
  }

  Future<bool> _addData({
    required String name,
    required int age,
    required String? imageUrl,
    required String dob,
    required String gender,
    required String location,
    required String? uid,
    required int mobile,
    required String department,
    required int experiance,
    required String form,
    required String to,
    List<bool>? availabledays,
    required String hospitalNAme,
    required int fees,
    String? about,
    required String certificates,
  }) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('doctor');

    final Map<String, dynamic> userData = {
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'dob': dob,
      'gender': gender,
      'location': location,
      'uid': uid,
      'mobile': mobile,
      'department': department,
      'experiance': experiance,
      'form': form,
      'to': to,
      'availabledays': availabledays,
      'hospitalNAme': hospitalNAme,
      'fees': fees,
      'about': about,
      'certificates': certificates
    };

    try {
      await userCollection.add(userData);
      print('Data added successfully!');
      return true; // Return true if data is added successfully
    } catch (error) {
      print('Error adding data: $error');
      return false; // Return false if an error occurs
    }
  }
  /////////////
}
