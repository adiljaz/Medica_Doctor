import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_doctor/blocs/profile/bloc/docurl_bloc.dart';

import 'package:media_doctor/screens/adprofiledata/widgets/approunderwidget.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path_provider/path_provider.dart';

class Userimage extends StatefulWidget {
  final Function(String) onFileChange;
  Userimage({required this.onFileChange});

  @override
  State<Userimage> createState() => _UserimageState();
}

class _UserimageState extends State<Userimage> {
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaquery = MediaQuery.of(context);
    return BlocBuilder<DocurlBloc, DocurlState>(
      builder: (context, state) {
        if (state is DocSelectedState) {
          imageUrl = state.imageUrl;
        }

        return Column(
          children: [
            if (imageUrl == null)
             Image.asset('assets/images/profileno.png',height: mediaquery.size.height*0.25,width: mediaquery.size.width*0.5, fit: BoxFit.cover,),
            if (imageUrl != null)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => _selectPhoto(),
                child: AppRoundedImage.url(imageUrl!, height: 180, width: 180),
              ),
            InkWell(
              onTap: () => _selectPhoto(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(imageUrl != null ? 'Change Photo' : 'Select Photo'),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _selectPhoto() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (croppedFile == null) {
      return;
    }

    final compressedFile = await compressImage(croppedFile.path, 35);
    await _uploadFile(compressedFile.path);
  }

  Future<XFile> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now().millisecondsSinceEpoch}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  Future<void> _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    BlocProvider.of<DocurlBloc>(context)
        .add(DocAddedEvent(imageUrl: fileUrl));

    widget.onFileChange(fileUrl);
  }
}
