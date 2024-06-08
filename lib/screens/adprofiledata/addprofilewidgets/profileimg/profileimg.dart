import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/screens/adprofiledata/widgets/userimage.dart';

class profileimg extends StatelessWidget {
  const profileimg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}