part of 'docimg_bloc.dart';

@immutable
sealed class DocimgEvent {}

class  DocchageEvent extends DocimgEvent{
  final String imageUrl;

  DocchageEvent({required this.imageUrl});

  
}








// part of 'image_adding_bloc.dart';

// @immutable
// abstract class DocAddingEvent {}

// class ImageChangedEvent extends DocAddingEvent {
//   final String imageUrl;

//   ImageChangedEvent(this.imageUrl);
// }
