// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:vonette_schools/models/user.dart';
import 'package:vonette_schools/services/authentication.dart';
import 'package:vonette_schools/services/database.dart';
import 'package:vonette_schools/shared/constants.dart';
import 'package:vonette_schools/shared/loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vonette_schools/screens/home/chatApp/widgets/singleMessage.dart';
import 'package:intl/intl.dart';
import 'package:bubble/bubble.dart';

class pinnedMessages extends StatefulWidget {
  final Function? togglePage;
  final Function? toggleLoad;
  const pinnedMessages({this.togglePage, this.toggleLoad});

  // creates background task which states which page is running
  // notice that button runs the toggleView functions from authen.dart that
  // switches between the register and sign in page.
  @override
  State<pinnedMessages> createState() => _pinnedMessagesState();
}

class _pinnedMessagesState extends State<pinnedMessages> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final fieldTextController = TextEditingController();
  final fieldTextController2 = TextEditingController();

  Color c1 = const Color(0xF6F6F6);

  String password = '';
  String conf_password = '';
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    // these conditions are used to get the height and the width of the screen
    // which are helpful in generating percentage values.
    double heigth_sc = MediaQuery.of(context).size.height;
    double width_sc = MediaQuery.of(context).size.width;
    final user = Provider.of<UserInApp?>(context);
    var isMe = false;
    void clearText() {
      fieldTextController.clear();
      fieldTextController2.clear();
    }

    int selectedValue = 1;
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: StreamBuilder(
                  stream: DatabaseService(user: user).getCurrentUserDM,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var name = snapshot.data['username'];
                      var email = snapshot.data['email'];
                      var imageUrl = snapshot.data['profile_url'];
                      return Form(
                          key: _formKey,
                          child: Column(children: [
                            Container(
                                height: heigth_sc * 0.290,
                                width: width_sc,
                                color: Colors.white,
                                child: Column(children: [
                                  const SizedBox(height: 60),
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(imageUrl)),
                                  const SizedBox(height: 10),
                                  Text('$name',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21)),
                                  const SizedBox(height: 5),
                                  Text('$email'),
                                  const SizedBox(height: 5),
                                ])),
                            Container(
                              width: width_sc,
                              color: const Color(0xF6F6F6),
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(width_sc * 0.045,
                                      heigth_sc * 0.02, 0, heigth_sc * 0.005),
                                  child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Pinned Messages',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)))),
                            ),
                            Column(
                              children: [
                                Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  padding: BubbleEdges.all(12),
                                  radius: Radius.circular(12),
                                  alignment: isMe
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  nip: isMe
                                      ? BubbleNip.rightTop
                                      : BubbleNip.leftTop,
                                  color: isMe
                                      ? messageMeColor
                                      : messageFriendColor,
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      "Here is an example pinned message!!",
                                      textAlign: isMe
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                          color: isMe
                                              ? textMeColor
                                              : textFriendColor),
                                    ),
                                  ),
                                ),
                                Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  padding: BubbleEdges.all(12),
                                  radius: Radius.circular(12),
                                  alignment: isMe
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  nip: isMe
                                      ? BubbleNip.rightTop
                                      : BubbleNip.leftTop,
                                  color: isMe
                                      ? messageMeColor
                                      : messageFriendColor,
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      "Pin messages from DMs or Clubs to add them here!",
                                      textAlign: isMe
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                          color: isMe
                                              ? textMeColor
                                              : textFriendColor),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]));
                    }
                    return Loading();
                  }),
            ),
            floatingActionButton: FloatingActionButton(
                mini: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.arrow_back)),
          );
  }
}
