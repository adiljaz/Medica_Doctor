import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/bloc/auth_bloc.dart';
import 'package:media_doctor/screens/authentication/login/login.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text('Hello WOrld'),
              IconButton(
                  onPressed: () {
                    final authbloc = BlocProvider.of<AuthBloc>(context);

                    authbloc.add(LogoutEvent());
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
        );
      },
    );
  }
}
