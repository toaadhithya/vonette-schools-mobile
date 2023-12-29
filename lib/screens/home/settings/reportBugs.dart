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

class reportBugs extends StatefulWidget {
  final Function? togglePage;
  final Function? toggleLoad;
  const reportBugs({this.togglePage, this.toggleLoad});

  // creates background task which states which page is running
  // notice that button runs the toggleView functions from authen.dart that
  // switches between the register and sign in page.
  @override
  State<reportBugs> createState() => _reportBugsState();
}

class _reportBugsState extends State<reportBugs> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final fieldTextController = TextEditingController();
  final fieldTextController2 = TextEditingController();

  Color c1 = const Color(0xF6F6F6);

  String password = '';
  String conf_password = '';
  bool loading = false;
  String error = '';
  String imageClubUrl = '';

  @override
  Widget build(BuildContext context) {
    // these conditions are used to get the height and the width of the screen
    // which are helpful in generating percentage values.
    double heigth_sc = MediaQuery.of(context).size.height;
    double width_sc = MediaQuery.of(context).size.width;
    final user = Provider.of<UserInApp?>(context);

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 20,
        height: 2,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    Future uploadProfilePicture() async {
      UploadTask? uploadTask;
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return null;

      final path = 'ClubProfilePhotos/${result.files.first.name}';
      final file = File(result.files.first.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        imageClubUrl = urlDownload;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: StreamBuilder(
              stream: DatabaseService(user: user).getCurrentUserDM,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var name = snapshot.data['username'];
                  var email = snapshot.data['email'];
                  var profileUrl = snapshot.data['profile_url'];
                  return Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                            height: heigth_sc * 0.25,
                            width: width_sc,
                            color: Colors.white,
                            child: Column(children: [
                              const SizedBox(height: 60),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(profileUrl)),
                              const SizedBox(height: 10),
                              Text('$name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21)),
                              const SizedBox(height: 5),
                              Text('$email'),
                            ])),
                        Container(
                          width: width_sc,
                          height: heigth_sc * 0.7,
                          color: const Color(0xF6F6F6),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          width_sc * 0.045,
                                          heigth_sc * 0.02,
                                          0,
                                          heigth_sc * 0.005),
                                      child: const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Report a Bug or User',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)))),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          width_sc * 0.1,
                                          heigth_sc * 0.01,
                                          0,
                                          0),
                                      height: heigth_sc * 0.04,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromARGB(
                                              255, 144, 98, 224),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                        ),
                                        onPressed: () {
                                          uploadProfilePicture();
                                        },
                                        child: const Text('Upload Screenshot',
                                            style: TextStyle(fontSize: 11.5)),
                                      ))
                                ],
                              ),
                              SizedBox(height: heigth_sc * 0.015),
                              SizedBox(
                                height: heigth_sc * 0.2,
                                width: width_sc * 0.92,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: heigth_sc * 0.2),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrange,
                                                width: 1.0)),
                                        label: Center(
                                            child: Text('What happened?')),
                                        floatingLabelStyle: TextStyle(
                                            color: Colors.deepOrange)),
                                    validator: (val) =>
                                        val!.isEmpty ? '' : null,
                                    onChanged: (val) {}),
                              ),
                              SizedBox(height: heigth_sc * 0.02),
                              SizedBox(
                                height: heigth_sc * 0.3,
                                width: width_sc * 0.92,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: heigth_sc * 0.3),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrange,
                                                width: 1.0)),
                                        label: Center(
                                            child: Text('Steps to Reproduce')),
                                        floatingLabelStyle: TextStyle(
                                          color: Colors.deepOrange,
                                        )),
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter Club Description'
                                        : null,
                                    onChanged: (val) {}),
                              ),
                              SizedBox(height: heigth_sc * 0.02),
                              SizedBox(height: heigth_sc * 0.02),
                              SizedBox(
                                width: width_sc * 0.335,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 144, 98, 224),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Send Request',
                                      style: TextStyle(fontSize: 11.5)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]));
                }
                return const Loading();
              })),
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
