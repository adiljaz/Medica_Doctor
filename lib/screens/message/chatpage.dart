import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_doctor/blocs/chat/chat_bloc.dart';
import 'package:media_doctor/blocs/chat/chat_event.dart';
import 'package:media_doctor/blocs/chat/chat_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.receiveUserId,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String receiveUserId;
  final String image;
  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  late ChatBloc _chatBloc;
  List<DocumentSnapshot> _messages = [];

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc();
    _chatBloc.add(FetchMessagesEvent(widget.receiveUserId));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _chatBloc.close(); // Close the bloc to avoid memory leaks
    super.dispose();
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final messageText = _messageController.text;
      _messageController.clear();
      _chatBloc.add(SendMessageEvent(widget.receiveUserId, messageText));
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              bloc: _chatBloc,
              listener: (context, state) {
                if (state is ChatMessageSent || state is ChatMessageDeleted) {
                  _chatBloc.add(FetchMessagesEvent(widget.receiveUserId));
                } else if (state is ChatLoaded) {
                  setState(() {
                    _messages = state.messages;
                  });
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    // Build message items
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
 