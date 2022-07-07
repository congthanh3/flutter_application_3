import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

import '../constants/all_constants.dart';
import '../models/chat_messages.dart';
import '../provider/auth_provider.dart';

import '../provider/chat_provider.dart';
import '../utilities/keyboard_utils.dart';
// import '../widgets/common_widgets.dart';
// import 'login_screen.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;
  // final String peerAvatar;
  // final String peerNickname;
  // final String userAvatar;

  const ChatScreen({
    Key? key,
    // required this.peerNickname,
    // required this.peerAvatar,
    required this.peerId,
    // required this.userAvatar,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentUserId;

  // List<QueryDocumentSnapshot> listMessages = [];

  // int _limit = 20;
  // final int _limitIncrement = 20;
  String groupChatId = '';

  File? imageFile;
  bool isLoading = false;
  // bool isShowSticker = false;
  String imageUrl = '';

  late TextEditingController textEditingController;
  // final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late ChatProvider chatProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    }
    textEditingController = TextEditingController();
    if (currentUserId.compareTo(widget.peerId) > 0) {
      groupChatId = '$currentUserId - ${widget.peerId}';
    } else {
      groupChatId = '${widget.peerId} - $currentUserId';
    }

    // focusNode.addListener(onFocusChanged);
    // scrollController.addListener(_scrollListener);
    // readLocal();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // _scrollListener() {
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     setState(() {
  //       _limit += _limitIncrement;
  //     });
  //   }
  // }

  // void onFocusChanged() {
  //   if (focusNode.hasFocus) {
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   }
  // }

  // void readLocal() {
  //   if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
  //     currentUserId = authProvider.getFirebaseUserId()!;
  //   } else {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LoginPage()),
  //         (Route<dynamic> route) => false);
  //   }
  //   if (currentUserId.compareTo(widget.peerId) > 0) {
  //     groupChatId = '$currentUserId - ${widget.peerId}';
  //   } else {
  //     groupChatId = '${widget.peerId} - $currentUserId';
  //   }
  //   chatProvider.updateFirestoreData(FirestoreConstants.pathUserCollection,
  //       currentUserId, {FirestoreConstants.chattingWith: widget.peerId});
  // }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFile();
      }
    }
  }

  // void getSticker() {
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  // Future<bool> onBackPressed() {
  //   if (isShowSticker) {
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   } else {
  //     chatProvider.updateFirestoreData(FirestoreConstants.pathUserCollection,
  //         currentUserId, {FirestoreConstants.chattingWith: null});
  //   }
  //   return Future.value(false);
  // }

  // void _callPhoneNumber(String phoneNumber) async {
  //   var url = 'tel://$phoneNumber';
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Error Occurred';
  //   }
  // }

  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      UploadTask uploadTask =
          chatProvider.uploadImageFile(imageFile!, fileName);

      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, MessageType.image.index);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      // print(e.code);
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }

  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendChatMessage(
          content, type, groupChatId, currentUserId, widget.peerId);
      // scrollController.animateTo(0,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  // // checking if received message
  // bool isMessageReceived(int index) {
  //   if ((index > 0 &&
  //           listMessages[index - 1].get(FirestoreConstants.idFrom) ==
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // // checking if sent message
  // bool isMessageSent(int index) {
  //   if ((index > 0 &&
  //           listMessages[index - 1].get(FirestoreConstants.idFrom) !=
  //               currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButton(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Text('Chatting with ${widget.peerNickname}'.trim()),
          actions: [
            IconButton(
              onPressed: () {
                // ProfileProvider profileProvider;
                // profileProvider = context.read<ProfileProvider>();
                // String callPhoneNumber =
                //     profileProvider.getPrefs(FirestoreConstants.phoneNumber) ??
                //         "";
                // _callPhoneNumber(callPhoneNumber);
              },
              icon: const Icon(Icons.phone),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
            child: Column(
              children: [
                buildListMessage(),
                buildMessageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButton(BuildContext context) async {
    Navigator.pop(context);
    return true;
    // final shouldPop = await showDialog<bool>(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const Text('Do you want to go back?'),
    //       actionsAlignment: MainAxisAlignment.spaceBetween,
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context, true);
    //           },
    //           child: const Text('Yes'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context, false);
    //           },
    //           child: const Text('No'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    // return shouldPop!;
  }

  Widget buildMessageInput() {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: Sizes.dimen_4),
              decoration: BoxDecoration(
                color: AppColors.orangeWeb,
                borderRadius: BorderRadius.circular(Sizes.dimen_30),
              ),
              child: IconButton(
                onPressed: getImage,
                icon: const Icon(
                  Icons.camera_alt,
                  size: Sizes.dimen_28,
                ),
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                child: TextField(
              focusNode: focusNode,
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: textEditingController,
              decoration:
                  kTextInputDecoration.copyWith(hintText: 'write here...'),
              onSubmitted: (value) {
                onSendMessage(value, MessageType.text.index);
              },
            )),
            const SizedBox(
              width: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: Sizes.dimen_4),
              decoration: BoxDecoration(
                color: AppColors.orangeWeb,
                borderRadius: BorderRadius.circular(Sizes.dimen_30),
              ),
              child: IconButton(
                onPressed: () {
                  onSendMessage(
                      textEditingController.text, MessageType.text.index);
                },
                icon: const Icon(Icons.send_rounded),
                color: AppColors.spaceLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListMessage() {
    return Expanded(
      flex: 9,
      child: GestureDetector(
        onTap: () {
          if (KeyboardUtils.isKeyboardShowing()) {
            KeyboardUtils.closeKeyboard(context);
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: chatProvider.getChatMessage(groupChatId, 20),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final listMessage = snapshot.data!.docs;
              if (listMessage.isNotEmpty) {
                return ListView.separated(
                  reverse: true,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: listMessage.length,
                  itemBuilder: (_, index) => buildItem(
                    index,
                    listMessage[index],
                  ),
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 10,
                  ),
                );
              } else {
                return const Center(
                  child: Text("no message..."),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      final chatMessages = ChatMessages.fromDocument(documentSnapshot);
      final bool isCurrentUser = chatMessages.idFrom == currentUserId;
      return Column(
        children: [
          Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              _buildMessage(chatMessages, isCurrentUser),
            ],
          )
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMessage(ChatMessages chatMessages, bool isCurrentUser) {
    if (chatMessages.type == MessageType.text.index) {
      return messageBubble(
          chatContent: chatMessages.content,
          color: isCurrentUser ? AppColors.indyBlue : AppColors.orangeWeb,
          textColor: isCurrentUser ? AppColors.white : AppColors.burgundy);
    } else if (chatMessages.type == MessageType.image.index) {
      return OutlinedButton(
        child: Image.network(
          chatMessages.content,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        onPressed: () {},
      );
    } else {
      return Text(chatMessages.type.toString());
    }
  }

  Widget messageBubble(
      {required String chatContent,
      EdgeInsetsGeometry? margin,
      Color? color,
      Color? textColor}) {
    return Container(
      padding: const EdgeInsets.all(Sizes.dimen_10),
      margin: margin ?? const EdgeInsets.all(5),
      width: Sizes.dimen_200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Sizes.dimen_10),
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
      ),
    );
  }
}
