import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show File, HttpHeaders;
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/CheckPassStatus.dart';
import 'package:tigramnks/Form.dart';
import 'package:tigramnks/sqflite/dataBase.dart';
import 'dart:developer' as logNK;

import 'model/formOneModel.dart';

class addLoc extends StatefulWidget {
  String userGroup;
  String sessionToken;

  String userName;
  String userEmail;

  int userId;
  final String Ids;
  addLoc(
      {this.sessionToken,
      this.userId,
      this.userGroup,
      this.Ids,
      this.userName,
      this.userEmail});

  @override
  State<addLoc> createState() =>
      _addLocState(sessionToken, userId, userGroup, Ids, userEmail, userName);
}

class _addLocState extends State<addLoc> {
  String sessionToken;
  String userGroup;
  String userName;
  String userEmail;

  int userId;
  final String Ids;
  String base64ImagePic1 = 'empty';
  var _image1;
  String base64ImagePic2 = 'empty';
  var _image2;
  String base64ImagePic3 = 'empty';
  var _image3;
  String base64ImagePic4 = 'empty';
  var _image4;
  String latImage1 = "";
  String longImage1 = "";
  String latImage2 = "";
  String longImage2 = "";
  String latImage3 = "";
  String longImage3 = "";
  String latImage4 = "";
  String longImage4 = "";
  bool isShow = false;

  _addLocState(this.sessionToken, this.userId, this.userGroup, this.Ids,
      this.userName, this.userEmail);

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void getCurrentLocation1() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi2 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage1 == "" || longImage1 == "") {
      getCurrentLocation1();
    }
    print(latImage1);
    setState(() {
      latImage1 = posi2.latitude.toString();
      longImage1 = posi2.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation2() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi3 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage2 == "" || longImage2 == "") {
      getCurrentLocation2();
    }
    print(latImage2);
    setState(() {
      latImage2 = posi3.latitude.toString();
      longImage2 = posi3.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation3() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi4 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage3 == "" || longImage3 == "") {
      getCurrentLocation3();
    }
    print(latImage3);
    setState(() {
      latImage3 = posi4.latitude.toString();
      longImage3 = posi4.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation4() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage4 == "" || longImage4 == "") {
      getCurrentLocation4();
    }
    print(latImage4);
    setState(() {
      latImage4 = posi1.latitude.toString();
      longImage4 = posi1.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  final picker = ImagePicker();

  Future<void> setfilepiccam() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image1 = File(pickedFile.path);
        base64ImagePic1 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic2() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image2 = File(pickedFile.path);
        base64ImagePic2 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic3() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image3 = File(pickedFile.path);
        base64ImagePic3 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic4() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image4 = File(pickedFile.path);
        base64ImagePic4 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showpickoptiondialogImg1(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccam();
                      },
                      splashColor: Colors.blueAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic2();
                      },
                      splashColor: Colors.blueAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg3(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic3();
                      },
                      splashColor: Colors.blueAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg4(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic4();
                      },
                      splashColor: Colors.blueAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: NewGradientAppBar(
              title: Text(
                "Update Location Images",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              gradient: LinearGradient(
                  colors: [HexColor("#26f596"), HexColor("#0499f2")]),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 0, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          getCurrentLocation1();
                          _showpickoptiondialogImg1(context);
                        });
                      },
                      label: const Text("Location site photograph 1"),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: ((_image1) == null && latImage1 == "")
                          ? Colors.red
                          : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 0, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          getCurrentLocation2();
                          _showpickoptiondialogImg2(context);
                        });
                      },
                      label: const Text("Location site photograph 2"),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: ((_image2) == null && latImage2 == "")
                          ? Colors.red
                          : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 0, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          getCurrentLocation3();
                          _showpickoptiondialogImg3(context);
                        });
                      },
                      label: const Text("Location site photograph 3"),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: ((_image3) == null && latImage3 == "")
                          ? Colors.red
                          : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 0, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          getCurrentLocation4();
                          _showpickoptiondialogImg4(context);
                        });
                      },
                      label: const Text("Location site photograph 4"),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: ((_image4) == null && latImage4 == "")
                          ? Colors.red
                          : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Visibility(
                  visible: isShow,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 8,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () async {
                        if ((latImage1.length == 0) ||
                            (latImage2.length == 0) ||
                            (latImage3.length == 0) ||
                            (latImage4.length == 0)) {
                          Fluttertoast.showToast(
                              msg: "Please select and fill all Field",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        } else {
                          setState(() {
                            //     print(base64ImageLisence);
                            isShow = true;
                          });
                          const String url =
                              'http://13.234.208.246api/auth/UpdateLocationImage';
                          Map data = {
                            "app_id": Ids,
                            "location_img1": {
                              "type": ".png",
                              // "image": ""
                              "image": base64ImagePic1
                            },
                            "location_img2": {
                              "type": ".png",
                              // "image": ""
                              "image": base64ImagePic2
                            },
                            "location_img3": {
                              "type": ".png",
                              // "image": ""
                              "image": base64ImagePic3
                            },
                            "location_img4": {
                              "type": ".png",
                              // "image": ""
                              "image": base64ImagePic1
                            },
                            "image1_lat": latImage1,
                            "image2_lat": latImage2,
                            "image3_lat": latImage3,
                            "image4_lat": latImage4,
                            "image1_log": longImage1,
                            "image2_log": longImage2,
                            "image3_log": longImage3,
                            "image4_log": longImage4,
                          };
                          print(data);
                          var body = json.encode(data);
                          print(body);
                          final response = await http.post(Uri.parse(url),
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization': "token $sessionToken"
                              },
                              body: body);
                          print(response.body);

                          Map<String, dynamic> responseJson =
                              json.decode(response.body);

                          print(
                              "----------------From Submit-----------------------");

                          print(responseJson);
                          if (responseJson['message'] !=
                              "Vehicles details updated successfully!") {
                            isShow = false;
                            Fluttertoast.showToast(
                                msg: "Something went wrong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }
                          await loginAction();
                          Fluttertoast.showToast(
                              msg: responseJson['message'].toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 8,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          setState(() {
                            isShow = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return CheckPassStatus(
                                        sessionToken: sessionToken,
                                        userName: userName,
                                        userEmail: userEmail,
                                        userGroup: userGroup);
                                  }));
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Cairo',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ))
              ]),
            )));
  }
}
