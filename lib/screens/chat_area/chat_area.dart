import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/all_constants.dart';
import '../../models/chat_user.dart';
import '../../provider/auth_provider.dart';
import '../../provider/home_provider.dart';
import '../../utilities/keyboard_utils.dart';
import 'chat_screen.dart';
import '../login_screen.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({Key? key}) : super(key: key);

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  late AuthProvider authProvider;
  late HomeProvider homeProvider;
  late String currentUserId;
  TextEditingController searchTextEditingController = TextEditingController();

  String _textSearch = "";
  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          vertical10,
          buildSearchBar(),
          vertical25,
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            builder: (context, snapshot) {
              final length = snapshot.data?.docs.length ?? 0;
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.hasError.toString()),
                );
              }
              if (snapshot.hasData) {
                if (length > 0) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: length,
                    itemBuilder: (context, index) => _buildItem(
                        context: context,
                        documentSnapshot: snapshot.data?.docs.elementAt(index)),
                    // controller: scrollController,
                  );
                } else {
                  return const Center(
                    child: Text('No user found...'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            stream: homeProvider.getFirestoreData(
                collectionPath: FirestoreConstants.pathUserCollection,
                textSearch: _textSearch),
          )),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(Sizes.dimen_10),
      height: Sizes.dimen_50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.person_search,
            color: AppColors.white,
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  // buttonClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  // buttonClearController.add(false);
                  setState(() {
                    _textSearch = "";
                  });
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_30),
        color: AppColors.orangeWeb,
      ),
    );
  }

  Widget _buildItem(
      {required BuildContext context, DocumentSnapshot? documentSnapshot}) {
    // final firebaseAuth = FirebaseAuth.instance;
    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
      if (userChat.id == currentUserId) {
        return const SizedBox.shrink();
      } else {
        return GestureDetector(
            onTap: () {
              if (KeyboardUtils.isKeyboardShowing()) {
                KeyboardUtils.closeKeyboard(context);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(peerId: userChat.id),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        userChat.photoUrl,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      userChat.displayName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                vertical15
              ],
            ));
      }
    }
    return const SizedBox.shrink();
  }
}
