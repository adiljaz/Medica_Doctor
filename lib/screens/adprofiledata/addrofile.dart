import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_bloc.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_event.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_state.dart';
import 'package:media_doctor/blocs/department/bloc/department_bloc.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_bloc.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_event.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_state.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_bloc.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_event.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_state.dart';
import 'package:media_doctor/blocs/profile/AddUser/add_user_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/blocs/profile/docimg/docimg_bloc.dart';
import 'package:media_doctor/blocs/totime/bloc/to_bloc.dart';
import 'package:media_doctor/blocs/totime/bloc/to_event.dart';
import 'package:media_doctor/blocs/totime/bloc/to_state.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/about/about.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/age/age.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/department/department.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dob.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/experiance/experiance.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/fees/fees.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/gender/gender.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/hospital/hospital.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/location/location.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/name/name.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/number/number.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/profileimg/profileimg.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/totime/totime.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/fromtime/fromtime.dart';
import 'package:media_doctor/screens/adprofiledata/addprofilewidgets/save/save.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/dropdown.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/time%20copy.dart';
import 'package:media_doctor/screens/bottomnav/bottomnav.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/docimage.dart';
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
  final TextEditingController _yearofexpeianceController = TextEditingController();
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
    ' Nutrition',
    'ophthalmologist  ',
    'Nephrology',
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

                          SizedBox(
                            height: mediaquery.size.height * 0.07,
                            child:
                                BlocBuilder<DateOfBirthBloc, DateOfBirthState>(
                              builder: (context, state) {
                                if (state is DateOfBirthSelectedState) {
                                  _datofbirthController.text =
                                      state.dateOfBirth;
                                }

                                return DateofBirth(
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
                                    });
                              },
                            ),
                          ),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),

                          //gender

                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, right: 20),
                            child: BlocBuilder<GenderBloc, GenderState>(
                              builder: (context, state) {
                                if (state is GenderSelectedState) {
                                  genderselectedvalue = state.selectedGender;
                                }
                                return Drobdown(
                                  onChange: (value) {
                                    if (value != null) {
                                      BlocProvider.of<GenderBloc>(context)
                                          .add(GenderSelected(value));
                                    }
                                  },
                                  genderItems: genderItems,
                                  typeText: 'Select Your Gender',
                                );
                              },
                            )),

                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: BlocBuilder<DepartmentBloc, DepartmentState>(
                            builder: (context, state) {
                              if (state is DepartmenetSelectedState) {
                                departmenetselectedvalue =
                                    state.selectedDepartment;
                              }

                              return Drobdown(
                                onChange: (value) {
                                  if (value != null) {
                                    BlocProvider.of<DepartmentBloc>(context)
                                        .add(DepartmenetSelected(
                                            selecteDepartment: value));
                                  }
                                  print(departmenetselectedvalue);
                                },
                                genderItems: departments,
                                typeText: 'Select your Department',
                              );
                            },
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
                              //ftomtime
                              Container(
                              height: mediaquery.size.height * 0.055,
                              width: mediaquery.size.width * 0.29,
                              child: BlocBuilder<FromTimeBloc, FromTimeState>(
                                builder: (context, state) {
                                  if (state is FromTimeInitial) {
                                    fromtime = state.time;
                                  } else if (state is FromTimeUpdated) {
                                    fromtime = state.time;
                                  } else {
                                    fromtime = TimeOfDay.now();
                                  }
                                  return AvailableTime(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: fromtime,
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                        );

                                        if (timeOfDay != null) {
                                          BlocProvider.of<FromTimeBloc>(
                                                  context)
                                              .add(FromTimeSelected(
                                                  timeOfDay));
                                        }
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode); 
                                      },
                                      controller: _fromController,
                                      labeltext:
                                          '${fromtime.hour % 12}:${fromtime.minute}');
                                },
                              ),
                            ),

                              SizedBox(
                                height: mediaquery.size.height * 0.055,
                                width: mediaquery.size.width * 0.29,
                                child: BlocBuilder<ToTimeBloc, ToTimeState>(
                                  builder: (context, state) {
                                    if (state is ToTimeInitial) {
                                      totime = state.time;
                                    } else if (state is ToTimeUpdated) {
                                      totime = state.time;
                                    } else {
                                      totime = TimeOfDay.now();
                                    }

                                    return AvailableTime(
                                      onTap: () async {
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: totime,
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                        );

                                        if (timeOfDay != null) {
                                          BlocProvider.of<ToTimeBloc>(context)
                                              .add(ToTimeSelected(timeOfDay));
                                        }
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode);
                                      },
                                      controller: _toController,
                                      labeltext:
                                          '${totime.hour % 12}:${totime.minute}',
                                    );
                                  },
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
                                    form: fromConvert(fromtime),
                                    to: toConvert(totime),
                                    hospitalNAme: hospital,
                                    about: about,
                                    certificates: docImageUrl,
                                  ));
                                }

                                 print(name);
                                print(age);
                                print(dob);
                                print(imageUrl);
                                print(genderselectedvalue);
                                print(departmenetselectedvalue);
                                print(experiance);
                                print(about);
                                print(fees);
                                print(docImageUrl);
                                print(hospital);
                                print(mbobilecontroller);
                                print(location);
                                print(fromtime);
                                print(totime);

                               
                                
                                _clearForm();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Bottomnav()),
                                    (route) => false);
                              }

                              
                            },
                            child: Save(mediaquery: mediaquery),
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
      lastDate: DateTime.now(),
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
      context.read<DateOfBirthBloc>().add(DateOfBirthSelected(_picked));
    }
  }

  String fromConvert(TimeOfDay fromtime) {
    final hours = fromtime.hourOfPeriod == 0 ? 12 : fromtime.hourOfPeriod;
    final minutes = fromtime.minute.toString().padLeft(2, '0');
    final period = fromtime.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hours:$minutes $period';
  }

  String toConvert(TimeOfDay totime) {
    final hours = totime.hourOfPeriod == 0 ? 12 : totime.hourOfPeriod;
    final minutes = totime.minute.toString().padLeft(2, '0');
    final period = totime.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hours:$minutes $period';
  }
}
