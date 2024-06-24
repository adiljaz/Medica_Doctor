import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';
import 'package:media_doctor/blocs/bottomnav/landing_state_bloc.dart';
import 'package:media_doctor/screens/adprofiledata/addrofile.dart';
import 'package:media_doctor/screens/appoinement/appoinement.dart';
import 'package:media_doctor/screens/authentication/login/login.dart';
import 'package:media_doctor/screens/message/message.dart';
import 'package:media_doctor/screens/profile/profile.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class Bottomnav extends StatelessWidget {
  Bottomnav({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavScren = <Widget>[
     Appointment(), 
      Text('Twooooooooooooooooo'),
    Message (), 
      Profile(),

      //  Profile(),
    ]; 

    return SafeArea(
      child: BlocBuilder<LandingStateBloc, LandingStateState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colormanager.scaffold,
            // appBar: AppBar(
            //   actions: [
            //     IconButton(
            //         onPressed: () {
            //           final authBloc = BlocProvider.of<AuthBloc>(context);
            //           authBloc.add(LogoutEvent());

            //           Navigator.of(context).pushAndRemoveUntil(
            //               MaterialPageRoute(builder: (context) => LoginPage()),
            //               (route) => false);
            //         },
            //         icon: Icon(Icons.logout))
            //   ],
            // ),

            body: bottomNavScren.elementAt(state.tabindex),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis)),
                ),
                child: NavigationBar(
                  backgroundColor: Colormanager.whiteContainer,
                  height: 65,
                  onDestinationSelected: (index) {
                    BlocProvider.of<LandingStateBloc>(context)
                        .add(TabChangeEvent(tabindex: index));
                  },
                  indicatorColor: Color.fromARGB(72, 197, 175, 221),
                  selectedIndex: state.tabindex,
                  destinations: const [
                    NavigationDestination(
                      icon: Badge(
                          child: Icon(
                        IconlyBold.calendar,
                        color: Colormanager.blackIcon,
                      )),
                      selectedIcon: Icon(
                        IconlyBold.calendar,
                        color: Colormanager.blueicon,
                      ),
                      label: 'Appoinment',
                    ),
                    NavigationDestination(
                      icon: Badge(
                        label: Text('2'),
                        child: Icon(
                          IconlyBold.message,
                          color: Colormanager.blackIcon,
                        ),
                      ),
                      selectedIcon: Icon(
                        IconlyBold.message,
                        color: Colormanager.blueicon,
                      ),
                      label: 'Message',
                    ),
                    NavigationDestination( 
                      icon: Badge(
                          child: Icon(
                        IconlyBold.bookmark,
                        color: Colormanager.blackIcon,
                      )),
                      selectedIcon: Icon(
                        IconlyBold.bookmark,
                        color: Colormanager.blueicon,
                      ),
                      label: 'Reviews',
                    ),
                    NavigationDestination(
                        selectedIcon: Icon(
                          IconlyBold.profile,
                          color: Colormanager.blueicon,
                        ),
                        icon: Icon(
                          IconlyBold.profile,
                          color: Colormanager.blackIcon,
                        ),
                        label: 'Profile'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
