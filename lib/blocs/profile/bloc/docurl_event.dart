part of 'docurl_bloc.dart';

@immutable
sealed class DocurlEvent {}

final class DocAddedEvent extends DocurlEvent {
  final String imageUrl;

  DocAddedEvent({required this.imageUrl});
}
