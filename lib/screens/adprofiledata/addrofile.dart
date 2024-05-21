import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/blocs/profile/AddUser/add_user_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/blocs/profile/docimg/docimg_bloc.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dob.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dropdown.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/time.dart';

import 'package:media_doctor/screens/bottomnav/home.dart';
import 'package:media_doctor/screens/profile/widget/certificates/docimage.dart';
import 'package:media_doctor/screens/profile/widget/userimage.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

import 'package:weekday_selector/weekday_selector.dart';

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
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _yearofexpeianceController =
      TextEditingController();

  final TextEditingController _aboutnameController = TextEditingController();

  final TextEditingController _hospitalnameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrl = '';

  final values = List.filled(7, true);

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final List<String> departments = [
    'Cardiologists',
    'Dentist',
    'Neurologists',
    'General',
    'Pediatrics',
    ' nutritionist',
    'ophthalmologist  ',
    'Radiologist',
    'Urologist',
  ];

  FocusNode myFocusNode = FocusNode();
  String? selectedValue;

  TimeOfDay fromtime = TimeOfDay.now();
  TimeOfDay totime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colormanager.scaffold,
      appBar: AppBar(
        backgroundColor: Colormanager.scaffold,
        title: Text(
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

                          Container(
                            height: mediaquery.size.height * 0.07,
                            child: DateofBirth(
                                value: (value) {},
                                controller: _datofbirthController,
                                labeltext: 'Date of birth',
                                onTap: () {
                                  _selectDAte();
                                  FocusScope.of(context)
                                      .requestFocus(myFocusNode);
                                }),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Drobdown(
                                genderItems: genderItems,
                                typeText: 'Select Your Gender',
                              )),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Drobdown(
                              genderItems: departments,
                              typeText: 'Select your Department',
                            ),
                          ),

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
                              keyboardtype: TextInputType.number,
                              fonrmtype: 'Year of Experiance',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _yearofexpeianceController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Year of Experiance';
                                }

                                return null;
                              }),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: Text(
                              'Working Time',
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: mediaquery.size.height * 0.055,
                                  width: mediaquery.size.width * 0.29,
                                  child: AvailableTime(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: fromtime,
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                        );

                                        if (timeOfDay != null) {
                                          setState(() {
                                            fromtime = timeOfDay;
                                          });
                                        }
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode);
                                      },
                                      controller: _fromController,
                                      value: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Add time';
                                        }

                                        return null;
                                      },
                                      labeltext:
                                          '${fromtime.hour % 12}:${fromtime.minute}')),
                              Container(
                                  height: mediaquery.size.height * 0.055,
                                  width: mediaquery.size.width * 0.29,
                                  child: AvailableTime(
                                    onTap: () async {
                                      final TimeOfDay? timeOfDay =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: totime,
                                        initialEntryMode:
                                            TimePickerEntryMode.input,
                                      );

                                      if (timeOfDay != null) {
                                        setState(() {
                                          totime = timeOfDay;
                                        });
                                      }
                                      FocusScope.of(context)
                                          .requestFocus(myFocusNode);
                                    },
                                    controller: _toController,
                                    value: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Add time';
                                      }

                                      return null;
                                    },
                                    labeltext:
                                        '${totime.hour % 12}:${totime.minute}',
                                  )),
                            ],
                          ),

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
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: WeekdaySelector(
                              selectedTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold, inherit: false),
                              shortWeekdays: const [
                                'Sun',
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                              ],
                              firstDayOfWeek: 7,
                              onChanged: (int day) {
                                setState(() {
                                  final index = day % 7;
                                  values[index] = !values[index];
                                  print(values);
                                });
                              },
                              values: values,
                            ),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          ProfileTextFormField(
                              keyboardtype: TextInputType.name,
                              fonrmtype: ' Hospital Name ',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _hospitalnameController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Hospital name';
                                }

                                return null;
                              }),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          ProfileTextFormField(
                              keyboardtype: TextInputType.number,
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

                          ProfileTextFormField(
                              minline: 10,
                              maxline: 1,
                              keyboardtype: TextInputType.name,
                              fonrmtype: ' About',
                              formColor: Colormanager.whiteContainer,
                              textcolor: Colormanager.grayText,
                              controller: _aboutnameController,
                              value: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add About';
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

  Future<void> _selectDAte() async {
    DateTime? _picked = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _datofbirthController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
