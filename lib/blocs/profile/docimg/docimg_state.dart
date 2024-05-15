part of 'docimg_bloc.dart';

@immutable
sealed class DocimgState {}

final class DocimgInitial extends DocimgState {}
class DocAddingInitial extends DocimgState {}

class DocSelectedState extends DocimgState {
  final String imageUrl;

  DocSelectedState({required this.imageUrl});
}

class DocSelectedNotDone extends DocimgState {}

class DocSeectedError extends DocimgState {}
 











// part of 'image_adding_bloc.dart';


// @immutable
// abstract class DocAddingState {}

