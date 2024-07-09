
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:media_doctor/screens/message/chatpage.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:shimmer/shimmer.dart';


class Message extends StatelessWidget {
  Message({Key? key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormanager.scaffold,
      appBar: AppBar(
        title: Text(
          'Medica Chat',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colormanager.blackText),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFFE94560)),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        backgroundColor: Colormanager.scaffold,
        elevation: 0,
      ),
      body: _buildDoctorList(),
    );
  }

  Widget _buildDoctorList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerList();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No doctors available', style: TextStyle(color: Colors.white)));
        }

        return AnimationLimiter(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildUserListItem(snapshot.data!.docs[index], context),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 6, // Adjust the number of shimmer items as needed
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                ),
                title: Container(
                  height: 16,
                  width: 100,
                  color: Colors.grey[300],
                ),
                subtitle: Container(
                  height: 14,
                  width: 150,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    String? uid = data['uid'];
    String? profile = data['imageUrl'];
    String name = data['name'] ?? 'Unknown';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(
              name: name,
              image: profile!,
              receiveUserId: uid,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(13, 100, 250, 0.507),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 69, 167, 233).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Hero(
                  tag: 'profile_$uid',
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: profile != null
                            ? NetworkImage(profile)
                            : AssetImage('assets/default_avatar.png') as ImageProvider,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                ),
                subtitle: StreamBuilder<QuerySnapshot>(
                  stream: _getLastMessageStream(uid!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('Start a conversation', style: TextStyle(color: Colors.grey[400]));
                    }

                    DocumentSnapshot lastMessage = snapshot.data!.docs.first;
                    Map<String, dynamic> lastMessageData = lastMessage.data() as Map<String, dynamic>;
                    String message = lastMessageData['message'] ?? 'No messages yet';
                    String messageType = lastMessageData['type'] ?? 'text';

                    return Text(
                      messageType == 'image' ? 'Sent an image' : message,
                      style: TextStyle(color: Colors.grey[400]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _getLastMessageStream(uid!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return SizedBox.shrink();
                    }

                    DocumentSnapshot lastMessage = snapshot.data!.docs.first;
                    Map<String, dynamic> lastMessageData = lastMessage.data() as Map<String, dynamic>;
                    Timestamp timestamp = lastMessageData['timestamp'] as Timestamp;
                    DateTime messageTime = timestamp.toDate();

                    String formattedTime = _getFormattedTime(messageTime);

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        formattedTime,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedTime(DateTime messageTime) {
    DateTime now = DateTime.now();
    if (now.difference(messageTime).inDays == 0) {
      return DateFormat('h:mm a').format(messageTime);
    } else if (now.difference(messageTime).inDays < 7) {
      return DateFormat('E').format(messageTime); // Day of week
    } else {
      return DateFormat('MMM d').format(messageTime);
    }
  }

  Stream<QuerySnapshot> _getLastMessageStream(String doctorUid) {
    String currentUserUid = _auth.currentUser!.uid;
    String chatId = _getChatId(currentUserUid, doctorUid);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  String _getChatId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join('_');
  }
}
