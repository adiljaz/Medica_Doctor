import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';

import 'package:media_doctor/screens/authentication/login/login.dart';
import 'package:media_doctor/screens/profile/editorifile/editprofile.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profileoptios/profileoptions.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final user = FirebaseFirestore.instance
        .collection('doctor')
        .where('uid', isEqualTo: _auth.currentUser!.uid);

    MediaQueryData mediaquery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colormanager.scaffold,
        body: StreamBuilder<QuerySnapshot>(
          stream: user.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No Data Vailable'),
              );
            }

            if (snapshot.hasData) {
              var userData = snapshot.data!.docs.first;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 90,
                        ),
                        SizedBox(
                          width: mediaquery.size.width * 0.15,
                        ),
                        Text(
                          'Profile',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => EditProfile(
                              //           age: userData['age'],
                              //           dob: userData['dob'],
                              //           gender: userData['gender'],
                              //           image: userData['imageUrl'],
                              //           location: userData['location'],
                              //           name: userData['name'],
                              //           uid: userData.id,
                              //           mobile: userData['mobile'],
                              //         )));
                            },
                            child: Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: userData['imageUrl'] != null
                                        ? Image.network(
                                            userData['imageUrl'],
                                            height:
                                                mediaquery.size.height * 0.25,
                                            width: mediaquery.size.width * 0.55,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/dr 5.jpg')))),
                        Positioned(
                            top: 120,
                            left: 145,
                            child: Icon(
                              Icons.add_to_photos,
                              size: 40,
                            ))
                      ],
                    ),
                    Text(
                      userData['name'] != null ? userData['name'] : 'add name ',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17)),
                    ),
                    Text(
                      userData['mobile'] != null
                          ? userData['mobile'].toString()
                          : 'add phone number',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => EditProfile(
                        //           age: userData['age'],
                        //           dob: userData['dob'],
                        //           gender: userData['gender'],
                        //           image: userData['imageUrl'],
                        //           location: userData['location'],
                        //           name: userData['name'],
                        //           uid: userData.id,
                        //           mobile: userData['mobile'],
                        //         )));

                        List<bool> availabledaysBoolList =
                            (userData['availabledays'] as List<dynamic>)
                                .map((item) => item as bool)
                                .toList();

                        Navigator.of(context).push(PageTransition(
                            child: EditProfile(
                              about: userData['about'],
                              age: userData['age'],
                              availabledays: availabledaysBoolList,
                              department: userData['department'],
                              dob: userData['dob'],
                              docImageurl: userData['certificates'],
                              experiace: userData['experiance'],
                              fees: userData['fees'],
                              from: userData['form'],
                              gender: userData['gender'],
                              hospitalName: userData['hospitalNAme'],
                              imageUrl: userData['imageUrl'],
                              location: userData['location'],
                              mobilenumber: userData['mobile'],
                              name: userData['name'],
                              to: userData['to'],
                            ),
                            type: PageTransitionType.fade));
                      },
                      child: ProfileOptions(
                        leadingIcon: Icons.account_circle,
                        typetext: 'EditProfile',
                        trialingIcon: Icons.navigate_next,
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    ProfileOptions(
                        leadingIcon: Icons.visibility,
                        typetext: 'Dark Mode',
                        trialingIcon: Icons.navigate_next),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    ProfileOptions(
                        leadingIcon: Icons.groups,
                        typetext: 'Invite friends',
                        trialingIcon: Icons.navigate_next),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    ProfileOptions(
                        leadingIcon: Icons.email,
                        typetext: 'Feed Back',
                        trialingIcon: Icons.navigate_next),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    ProfileOptions(
                        leadingIcon: Icons.security,
                        typetext: 'Privacy Policy',
                        trialingIcon: Icons.navigate_next),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    GestureDetector(
                      onTap: () {
                        final authBloc = BlocProvider.of<AuthBloc>(context);
                        authBloc.add(LogoutEvent());

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                      child: ProfileOptions(
                          leadingIcon: IconlyLight.logout,
                          typetext: 'Logout ',
                          trialingIcon: Icons.navigate_next),
                    ),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
