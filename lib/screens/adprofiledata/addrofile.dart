import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:media_doctor/blocs/profile/AddUser/add_user_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/blocs/profile/docimg/docimg_bloc.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/about/about.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/age/age.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dob.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dropdown.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/experiance/experiance.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/fees/fees.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/hospital/hospital.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/location/location.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/name/name.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/number/number.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/profileImg/profileimg.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/time.dart';
import 'package:media_doctor/screens/bottomnav/home.dart';
import 'package:media_doctor/screens/profile/widget/certificates/docimage.dart';

import 'package:media_doctor/utils/colors/colormanager.dart';

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
  final TextEditingController _feescontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String imageUrl = '';
  String docImageUrl = '';

  final values = List.filled(7, true);

  String? genderselectedvalue;
  String? departmenetselectedvalue;

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

  List<bool>? availabledays;
  FocusNode myFocusNode = FocusNode();

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
            docImageUrl = state.docimageUrl;
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
                            child: profileimg(),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          name(nameController: _nameController),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Age(ageController: _ageController),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          Container(
                            height: mediaquery.size.height * 0.07,
                            child: DateofBirth(
                                value: (value) {
                                  if (value!.isEmpty) {
                                    return 'Add Date of Birth';
                                  }
                                  return null;
                                },
                                controller: _datofbirthController,
                                labeltext: 'Date of birth',
                                onTap: () {
                                  _selectDate();

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
                                onChange: (value) {
                                  setState(() {
                                    genderselectedvalue = value;
                                  });

                                  print(genderselectedvalue);
                                },
                                genderItems: genderItems,
                                typeText: 'Select Your Gender',
                              )),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Drobdown(
                              onChange: (value) {
                                setState(() {
                                  departmenetselectedvalue = value;
                                });

                                print(departmenetselectedvalue);
                              },
                              genderItems: departments,
                              typeText: 'Select your Department',
                            ),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          MobileNumber(mbobilecontroller: _mbobilecontroller),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Location(locationcontroler: _locationcontroler),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Experiance(
                              yearofexpeianceController:
                                  _yearofexpeianceController),
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
                                    labeltext:
                                        '${fromtime.hour % 12}:${fromtime.minute}'),
                              ),
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
                                  availabledays = values;
                                });
                              },
                              values: values,
                            ),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          HospitalName(
                              hospitalnameController: _hospitalnameController),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Fees(feescontroller: _feescontroller),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          About(aboutnameController: _aboutnameController),

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
                                  .add(DocchageEvent(imageUrl: changingImage));
                            }),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          GestureDetector(
                            onTap: () {
                              if (imageUrl.isNotEmpty && docImageUrl.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Please upload your certificates'),
                                  ),
                                );
                              }

                              if (imageUrl.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('please add profile photo'),
                                  ),
                                );
                              }

                              if (_formkey.currentState!.validate() &&
                                  imageUrl.isNotEmpty) {
                                Navigator.of(context).pop();
                                FocusScope.of(context).unfocus();
                                final name = _nameController.text;
                                final dob = _datofbirthController.text;
                                final age = int.parse(_ageController.text);

                                final location = _locationcontroler.text;
                                final mbobilecontroller =
                                    int.parse(_mbobilecontroller.text);

                                final experiance =
                                    int.parse(_yearofexpeianceController.text);

                                final fees = int.parse(_feescontroller.text);

                                final hospital = _hospitalnameController.text;
                                final about = _aboutnameController.text;

                                if (imageUrl.isNotEmpty) {
                                  BlocProvider.of<AddUserBloc>(context)
                                      .add(AddUserClick(
                                    name: name,
                                    age: age,
                                    dob: dob,
                                    imageUrl: imageUrl,
                                    gender: genderselectedvalue!,
                                    location: location,
                                    mobile: mbobilecontroller,
                                    availabledays: availabledays,
                                    department: departmenetselectedvalue!,
                                    experiance: experiance,
                                    fees: fees,
                                    form: fromtime.toString(),
                                    to: totime.toString(),
                                    hospitalNAme: hospital,
                                    about: about,
                                    certificates: docImageUrl,
                                  ));

                                  // print("  name  :- ${name}");
                                  // print(age);
                                  // print(" dob:-  ${dob}");
                                  // print(imageUrl);
                                  // print("gender:- ${genderselectedvalue}");
                                  // print(location);
                                  // print(mbobilecontroller);
                                  // print("availabeDays:-${availabledays}");
                                  // print(" drdepartment:-  ${departmenetselectedvalue}");
                                  // print("experiance:- ${experiance}");
                                  // print(fees);
                                  // print("from  ${fromtime}");
                                  // print(" to ${totime}");
                                  // print(hospital);
                                  // print(about);
                                  // print("docimage:- ${docImageUrl}");
                                }
                                _clearForm();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Bottomnav()),
                                    (route) => false);
                              }

                              // print(
                              //     '---------------------------------------------------------------');

                              // print(_nameController.text);
                              // print(_ageController.text);
                              // print(_datofbirthController.text);
                              // print(imageUrl);
                              // print(genderselectedvalue);
                              // print(_locationcontroler.text);
                              // print(_mbobilecontroller.text);
                              // print(availabledays);
                              // print(departmenetselectedvalue);
                              // print(_yearofexpeianceController.text);
                              // print(_feescontroller.text);
                              // print(fromtime);
                              // print(totime);
                              // print(_hospitalnameController.text);
                              // print(_aboutnameController.text);
                              // print(docImageUrl);

                              // print(
                              //     '---------------------------------------------------------------');
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
    docImageUrl = '';
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colormanager.blueContainer,
            colorScheme: ColorScheme.light(
              primary: Colormanager.blueContainer,
              onPrimary: Colors.white,
              onSurface: const Color.fromARGB(255, 223, 223, 223),
            ),
            dialogBackgroundColor: const Color.fromARGB(255, 174, 174, 174),
            textTheme: TextTheme(),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.black,
              headerBackgroundColor: Colors.grey,
              headerForegroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (_picked != null) {
      setState(() {
        _datofbirthController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
