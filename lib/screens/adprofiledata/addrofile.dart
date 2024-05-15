import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/blocs/profile/AddUser/add_user_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/blocs/profile/docimg/docimg_bloc.dart';
import 'package:media_doctor/blocs/week/week_bloc.dart';
import 'package:media_doctor/screens/bottomnav/home.dart';
import 'package:media_doctor/screens/profile/widget/certificates/docimage.dart';
import 'package:media_doctor/screens/profile/widget/userimage.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';
import 'package:media_doctor/widgets/week/week.dart';

// ignore: must_be_immutable
class AddProfile extends StatefulWidget {
  AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _datofbirthController = TextEditingController();

  final TextEditingController _gendercontroller = TextEditingController();

  final TextEditingController _locationcontroler = TextEditingController();

  final TextEditingController _mbobilecontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colormanager.scaffold,
      appBar: AppBar(
        backgroundColor: Colormanager.scaffold,
        title: const Text(
          'Add Profile',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DocimgBloc, DocimgState>(
        builder: (context, state) {
          if (state is DocSelectedState) {
            imageUrl = state.imageUrl;
          }
          return BlocBuilder<ImageAddingBloc, ImageAddingState>(
            builder: (context, state) {
              if (state is ImageSelectedState) {
                imageUrl = state.imageUrl; // Update imageUrl when state changes
              }

              return BlocConsumer<AddUserBloc, AddUserState>(
                listener: (context, state) {
                  if (state is AddUserLOadingState) {
                    // Show loading indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Loading...')),
                    );
                    _clearForm();
                  } else if (state is AddUserSuccesState) {
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User added successfully!')),
                    );
                    _clearForm();

                    // Clear form and navigate away after success

                    Navigator.of(context).pop();
                  } else if (state is AddUserErrorState) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.errorMessage}')),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Userimage(onFileChange: (changingImage) {
                                  BlocProvider.of<ImageAddingBloc>(context)
                                      .add(ImageChangedEvent(changingImage));
                                }),
                                Positioned(
                                    top: 120,
                                    left: 145,
                                    child: Icon(
                                      Icons.add_to_photos,
                                      size: 40,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.name,
                              fonrmtype: 'Name ',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _nameController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Name ';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.number,
                              fonrmtype: 'Age ',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _ageController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add age ';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.number,
                              fonrmtype: 'Date of Birth',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _datofbirthController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Date of Birth ';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.text,
                              fonrmtype: 'Gender ',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _gendercontroller,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Gender';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.number,
                              fonrmtype: 'Mobile Number ',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _mbobilecontroller,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mobile Number ';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.text,
                              fonrmtype: 'Location',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _locationcontroler,
                              suficon: const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 211, 14, 0),
                              ),
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Location';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.text,
                              fonrmtype: 'Year of Experiance',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _locationcontroler,
                              suficon: const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 211, 14, 0),
                              ),
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Year of Experiance';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.text,
                              fonrmtype: 'Working time',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _locationcontroler,
                              suficon: const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 211, 14, 0),
                              ),
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Working time';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Text('Available Days',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600))),
                          ),

                          ///

                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                                height: mediaquery.size.height * 0.08,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BlocBuilder<WeekBloc, WeekState>(
                                      builder: (context, state) {
                                        final st =
                                            BlocProvider.of<WeekBloc>(context)
                                                .state;
                                        return GestureDetector(
                                          onTap: () {
                                            final st =
                                                BlocProvider.of<WeekBloc>(
                                                        context)
                                                    .state;

                                            if (st is Sundaychange) {
                                              BlocProvider.of<WeekBloc>(
                                                      context)
                                                  .add(SundayClick (
                                                      sunday: false));
                                            } else {
                                              BlocProvider.of<WeekBloc>(
                                                      context)
                                                  .add(SundayClick (
                                                      sunday: true));
                                            }
                                          },
                                          child: Weeklydays(
                                            color: state is  Sundaychange
                                                ?Colormanager.blueContainer:Colormanager.whiteContainer, 
                                            day: 'Su',
                                          ),
                                        );
                                      },
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'Mo',
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'Tu',
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'We',
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'Th',
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'Fr',
                                    ),
                                    Weeklydays(
                                      color: Colormanager.blueContainer,
                                      day: 'Sa',
                                    ),
                                  ],
                                )),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.text,
                              fonrmtype: 'consultation fees',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _locationcontroler,
                              suficon: const Icon(
                                Icons.currency_rupee_sharp,
                                color: Colormanager.blackIcon,
                              ),
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add consultation fees';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Text(
                              'Add your certifictes',
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Center(
                            child: Docimage(onFileChange: (changingImage) {
                              BlocProvider.of<DocimgBloc>(context)
                                  .add(DocchageEvent(imageUrl: imageUrl));
                            }),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (imageUrl.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Failed to upload image. Please try again.'),
                                  ),
                                );
                              }

                              if (_formkey.currentState!.validate() &&
                                  imageUrl.isNotEmpty) {
                                Navigator.of(context).pop();
                                FocusScope.of(context).unfocus();
                                final name = _nameController.text;
                                final dob =
                                    int.parse(_datofbirthController.text);
                                final age = int.parse(_ageController.text);
                                final gender = _gendercontroller.text;
                                final location = _locationcontroler.text;
                                final mbobilecontroller =
                                    int.parse(_mbobilecontroller.text);
                                if (imageUrl.isNotEmpty) {
                                  BlocProvider.of<AddUserBloc>(context)
                                      .add(AddUserClick(
                                    name: name,
                                    age: age,
                                    dob: dob,
                                    imageUrl: imageUrl,
                                    gender: gender,
                                    location: location,
                                    mobile: mbobilecontroller,
                                  ));
                                }
                                _clearForm();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Bottomnav()),
                                    (route) => false);
                              }
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colormanager.blueContainer,
                                    borderRadius: BorderRadius.circular(10)),
                                height: mediaquery.size.width * 0.14,
                                width: mediaquery.size.height * 0.4,
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colormanager.whiteText),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _ageController.clear();
    _datofbirthController.clear();
    _gendercontroller.clear();
    _locationcontroler.clear();
    imageUrl = '';
  }
}
