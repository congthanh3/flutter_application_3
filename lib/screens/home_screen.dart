import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/all_constants.dart';
import '../enum/bottom_type.dart';
import '../generated/l10n.dart';
import '../provider/main_provider.dart';
import '../widgets/w_bottom_navigation_item.dart';
import '../widgets/w_custom_appbar.dart';
import 'chat_area/chat_area.dart';
import 'movie_area/movie_area.dart';
import 'photo_area/photo_area.dart';
import 'side_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomType bottomType = BottomType.listDevice;

  final pages = [
    const ChatArea(),
    const MovieArea(),
    const PhotoArea(),
  ];

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
        appBar: const CustomAppBar(),
        key: mainProvider.getGlobalKey,
        drawer: const SideNavigationBar(),
        body: Stack(
          children: [
            pages[mainProvider.getIndex],
            Positioned(
              bottom: 0,
              left: 0,
              child: buildMyNavBar(
                context,
              ),
            )
          ],
        ) //
        );
  }

  SafeArea buildMyNavBar(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68,
        width: MediaQuery.of(context).size.width * 1,
        decoration:
            containerStyle(color: AppColors.white, topLeft: 20, topRight: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationItem(
              index: BottomType.listDevice.index,
              activeImage: AppAssets.iconBack,
              notActiveImage: AppAssets.iconCancel,
              notActiveName: S.of(context).test,
            ),
            BottomNavigationItem(
              index: BottomType.networkControl.index,
              activeImage: AppAssets.iconBack,
              notActiveImage: AppAssets.iconCancel,
              notActiveName: S.of(context).test,
            ),
            BottomNavigationItem(
              index: BottomType.wifiSetting.index,
              activeImage: AppAssets.iconBack,
              notActiveImage: AppAssets.iconCancel,
              notActiveName: S.of(context).test,
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
  //   final firebaseAuth = FirebaseAuth.instance;
  //   if (documentSnapshot != null) {
  //     ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
  //     if (userChat.id == currentUserId) {
  //       return const SizedBox.shrink();
  //     } else {
  //       return TextButton(
  //         onPressed: () {
  //           if (KeyboardUtils.isKeyboardShowing()) {
  //             KeyboardUtils.closeKeyboard(context);
  //           }
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => ChatPage(
  //                         peerId: userChat.id,
  //                         peerAvatar: userChat.photoUrl,
  //                         peerNickname: userChat.displayName,
  //                         userAvatar: firebaseAuth.currentUser!.photoURL!,
  //                       )));
  //         },
  //         child: ListTile(
  //           leading: userChat.photoUrl.isNotEmpty
  //               ? ClipRRect(
  //                   borderRadius: BorderRadius.circular(Sizes.dimen_30),
  //                   child: Image.network(
  //                     userChat.photoUrl,
  //                     fit: BoxFit.cover,
  //                     width: 50,
  //                     height: 50,
  //                     loadingBuilder: (BuildContext ctx, Widget child,
  //                         ImageChunkEvent? loadingProgress) {
  //                       if (loadingProgress == null) {
  //                         return child;
  //                       } else {
  //                         return SizedBox(
  //                           width: 50,
  //                           height: 50,
  //                           child: CircularProgressIndicator(
  //                               color: Colors.grey,
  //                               value: loadingProgress.expectedTotalBytes !=
  //                                       null
  //                                   ? loadingProgress.cumulativeBytesLoaded /
  //                                       loadingProgress.expectedTotalBytes!
  //                                   : null),
  //                         );
  //                       }
  //                     },
  //                     errorBuilder: (context, object, stackTrace) {
  //                       return const Icon(Icons.account_circle, size: 50);
  //                     },
  //                   ),
  //                 )
  //               : const Icon(
  //                   Icons.account_circle,
  //                   size: 50,
  //                 ),
  //           title: Text(
  //             userChat.displayName,
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // int _limit = 20;
  // final int _limitIncrement = 20;
  // String _textSearch = "";
  // bool isLoading = false;

  // late AuthProvider authProvider;
  // late String currentUserId;
  // late HomeProvider homeProvider;

  // Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  // StreamController<bool> buttonClearController = StreamController<bool>();
  // TextEditingController searchTextEditingController = TextEditingController();

  // Future<void> googleSignOut() async {
  //   authProvider.googleSignOut();
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const LoginPage()));
  // }

  // Future<bool> onBackPress() {
  //   openDialog();
  //   return Future.value(false);
  // }

  // Future<void> openDialog() async {
  //   switch (await showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return SimpleDialog(
  //           backgroundColor: AppColors.burgundy,
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: const [
  //               Text(
  //                 'Exit Application',
  //                 style: TextStyle(color: AppColors.white),
  //               ),
  //               Icon(
  //                 Icons.exit_to_app,
  //                 size: 30,
  //                 color: Colors.white,
  //               ),
  //             ],
  //           ),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(Sizes.dimen_10),
  //           ),
  //           children: [
  //             vertical10,
  //             const Text(
  //               'Are you sure?',
  //               textAlign: TextAlign.center,
  //               style:
  //                   TextStyle(color: AppColors.white, fontSize: Sizes.dimen_16),
  //             ),
  //             vertical15,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 SimpleDialogOption(
  //                   onPressed: () {
  //                     Navigator.pop(context, 0);
  //                   },
  //                   child: const Text(
  //                     'Cancel',
  //                     style: TextStyle(color: AppColors.white),
  //                   ),
  //                 ),
  //                 SimpleDialogOption(
  //                   onPressed: () {
  //                     Navigator.pop(context, 1);
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: AppColors.white,
  //                       borderRadius: BorderRadius.circular(Sizes.dimen_8),
  //                     ),
  //                     padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
  //                     child: const Text(
  //                       'Yes',
  //                       style: TextStyle(color: AppColors.spaceCadet),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         );
  //       })) {
  //     case 0:
  //       break;
  //     case 1:
  //       exit(0);
  //   }
  // }

  // void scrollListener() {
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     setState(() {
  //       _limit += _limitIncrement;
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   buttonClearController.close();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   authProvider = context.read<AuthProvider>();
  //   homeProvider = context.read<HomeProvider>();
  //   if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
  //     currentUserId = authProvider.getFirebaseUserId()!;
  //   } else {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LoginPage()),
  //         (Route<dynamic> route) => false);
  //   }

  //   scrollController.addListener(scrollListener);
  // }

}
