part of 'docurl_bloc.dart';

@immutable
sealed class DocurlState {}

final class DocurlInitial extends DocurlState {}

final class DocSelectedState extends DocurlState {
  final String imageUrl;

  DocSelectedState({required this.imageUrl});
  
}

class DocselectedDone extends DocurlState {}

class DocError extends DocurlState {}


