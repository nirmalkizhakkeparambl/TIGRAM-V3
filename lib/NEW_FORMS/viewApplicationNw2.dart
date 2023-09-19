import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show File;
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/Images.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/ViewApplication1.dart';

class viewApplicationNw2 extends StatefulWidget {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String userName;
  String userEmail;
  String img_signature;
  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  String field_status;
  viewApplicationNw2(
      {this.sessionToken,
      this.userId,
      this.Ids,
      this.Range,
      this.userName,
      this.userEmail,
      this.img_signature,
      this.userGroup,
      this.verify_officer,
      this.deputy_range_officer,
      this.verify_range_officer,
      this.is_form_two,
      this.assigned_deputy2_id,
      this.assigned_deputy1_id,
      this.verify_deputy2,
      this.division_officer,
      this.other_state,
      this.verify_forest1,
      this.field_requre,
      this.field_status});

  @override
  State<viewApplicationNw2> createState() => _viewApplicationNw2State(
      sessionToken,
      userId,
      Ids,
      Range,
      userName,
      userEmail,
      img_signature,
      userGroup,
      verify_officer,
      deputy_range_officer,
      verify_range_officer,
      is_form_two,
      assigned_deputy2_id,
      assigned_deputy1_id,
      verify_deputy2,
      division_officer,
      other_state,
      verify_forest1,
      field_requre,
      field_status);
}

class _viewApplicationNw2State extends State<viewApplicationNw2> {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String userName;
  String userEmail;

  String img_signature;
  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  String field_status;

  _viewApplicationNw2State(
      this.sessionToken,
      this.userId,
      this.Ids,
      this.Range,
      this.userName,
      this.userEmail,
      this.img_signature,
      this.userGroup,
      this.verify_officer,
      this.deputy_range_officer,
      this.verify_range_officer,
      this.is_form_two,
      this.assigned_deputy2_id,
      this.assigned_deputy1_id,
      this.verify_deputy2,
      this.division_officer,
      this.other_state,
      this.verify_forest1,
      this.field_requre,
      this.field_status);

  void initState() {
    super.initState();
    setState(() {
      listDeputy();
    });
  }

  String base64ImagePic1 = "";
  var _image1;
  String base64ImagePic2 = "";
  var _image2;
  String base64ImagePic3 = "";
  var _image3;
  String base64ImagePic4 = "";
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

  bool can_assign_officer = false;
  bool transit_pass_exist = false;
  bool reject_visible = false;
  bool feild_butt_deputy = false;
  bool feild_butt_range = false;
  bool approve_deputy = false;
  bool approvefinal = false;

  Map DisableButton(
      String userGroup,
      bool verify_officer,
      bool deputy_range_officer,
      bool verify_range_officer,
      bool is_form_two,
      int userId,
      int assigned_deputy2_id,
      int assigned_deputy1_id,
      bool verify_deputy2,
      bool division_officer,
      bool other_state,
      bool verify_forest1,
      String field_requre,
      String field_status) {
    can_assign_officer = false;
    transit_pass_exist = true;
    reject_visible = false;
    feild_butt_range = true;

    if (userGroup == 'forest range officer') {
      if (is_form_two == false &&
          assigned_deputy1_id == null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;

        //--assign F1

      }
      if (is_form_two == true && // notified
          assigned_deputy1_id == null &&
          verify_range_officer == false &&
          verify_forest1 == false) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;
        feild_butt_range = true;
        approvefinal = true;

        //--assign F2
        //- - range field verification

      }
      if (is_form_two == false && //nonNot
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          verify_forest1 == false) {
        can_assign_officer = false;
        transit_pass_exist = false;
        reject_visible = true;

        approvefinal = true;

        //--assign F1
        //- - range field verification

      }
      if (is_form_two == false && //nonNot
          assigned_deputy1_id != null &&
          verify_range_officer == true &&
          verify_forest1 == true) {
        can_assign_officer = false;
        transit_pass_exist = false;
        reject_visible = false;

        approvefinal = false;
      }
      if (is_form_two == true &&
          assigned_deputy1_id != null &&
          verify_range_officer == true &&
          verify_forest1 == true) {
        can_assign_officer = false;
        transit_pass_exist = false;
        reject_visible = false;

        approvefinal = false;
      }
    } else if (userGroup == 'deputy range officer') {
      if (is_form_two == false && //nonNot
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          verify_forest1 == false) {
        can_assign_officer = false;
        transit_pass_exist = false;
        reject_visible = false;
        feild_butt_deputy = true;
        approve_deputy = true;
      }
      if (is_form_two == true && //nonNot
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          verify_forest1 == false) {
        can_assign_officer = false;
        transit_pass_exist = false;
        reject_visible = false;
        feild_butt_deputy = true;
        approve_deputy = true;
      }
    }
    feild_butt_range = true;
    return {
      'can_assign_officer': can_assign_officer,
      'transit_pass_exist': transit_pass_exist,
      'reject_visible': reject_visible,
      'feild_butt_range': feild_butt_range
    };
  }

  int dropdownValue3; // Store the selected 'id'
  List<Map<String, dynamic>> apiResponse = [];
  listDeputy() async {
    String url = 'http://13.234.208.246/api/auth/get_deputies/';
    Map data = {"range": 75};
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(body.toString());
    print("-----------------View -Deputies------------");
    List list = responseJSON["deputy range officers"];
    setState(() {
      apiResponse =
          list.cast<Map<String, dynamic>>(); // Store the API response data
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text("View Application"),
          gradient: LinearGradient(
              colors: [HexColor("#26f596"), HexColor("#0499f2")]),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(width: 0, height: 0, color: Colors.white),
              Visibility(
                  visible: DisableButton(
                      userGroup,
                      verify_officer,
                      deputy_range_officer,
                      verify_range_officer,
                      is_form_two,
                      userId,
                      assigned_deputy2_id,
                      assigned_deputy1_id,
                      verify_deputy2,
                      division_officer,
                      other_state,
                      verify_forest1,
                      field_requre,
                      field_status)["can_assign_officer"],
                  child: ElevatedButton(
                    onPressed: () {
                      print(Range);
                      AssignOfficerDialog(context);
                    },
                    child: Text(
                      'Assign Officer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(
                    right: 15.0, top: 15, left: 15, bottom: 0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ImageView(
                                      Images: img_signature.toString(),
                                    )));
                      },
                      child: Image.network(
                        img_signature.toString(),
                        fit: BoxFit.fill,
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Text('Signature')
                  ],
                ),
              ),
              Visibility(
                visible: DisableButton(
                    userGroup,
                    verify_officer,
                    deputy_range_officer,
                    verify_range_officer,
                    is_form_two,
                    userId,
                    assigned_deputy2_id,
                    assigned_deputy1_id,
                    verify_deputy2,
                    division_officer,
                    other_state,
                    verify_forest1,
                    field_requre,
                    field_status)["feild_butt_range"],
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
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                      Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: ((_image1) == null) && (latImage1 == "")
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
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                      Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: ((_image2) == null) && (latImage2 == "")
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
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                      Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: ((_image3) == null) && (latImage3 == "")
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
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                      Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: ((_image4) == null) && (latImage4 == "")
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
                                'http://13.234.208.246api/auth/field_verify/';
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
                                      return OfficerDashboard(
                                          sessionToken: sessionToken,
                                          userName: userName,
                                          userEmail: userEmail,
                                          userGroup: userGroup);
                                    }));
                          }
                        },
                        child: Text(
                          'Submit Field Data',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Cairo',
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ))
                ]),
              ),
              LayoutBuilder(builder: (context, constraints) {
                if (userGroup == 'deputy range officer') {
                  return Container(
                    width: 0,
                    height: 0,
                    color: Colors.white,
                  );
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                    color: Colors.white,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => ViewApplication1()),
    );
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

  Future<void> AssignOfficerDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          print(Range.toString());
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: dropdownValue3,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select Officer",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " * ",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 16,
                            )),
                      ]),
                    ),
                    onChanged: (int id) {
                      setState(() {
                        dropdownValue3 = id;
                        print(dropdownValue3);
                      });
                    },
                    items: apiResponse.map<DropdownMenuItem<int>>(
                      (Map<String, dynamic> item) {
                        return DropdownMenuItem<int>(
                          value: item['id'] as int,
                          child: Text(item['name'].toString()),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              title: Text('Assign Deputy Range Officer'),
              actions: <Widget>[
                InkWell(
                  child: Text(
                    'OK ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () async {
                    const String url =
                        'http://13.234.208.246/api/auth/FormTwoAssignDeputy';
                    Map data = {"app_id": Ids, "deputy_id": dropdownValue3};
                    print(data);
                    var body = json.encode(data);
                    print(body);
                    final response = await http.post(Uri.parse(url),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Authorization': "token $sessionToken"
                        },
                        body: body);
                    print(response);
                    Map<String, dynamic> responseJson =
                        json.decode(response.body);
                    print("----------------------login----------------");
                    Fluttertoast.showToast(
                        msg: responseJson['message'].toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 8,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    print(responseJson);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OfficerDashboard(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userEmail,
                                  userGroup: userGroup,
                                )));
                  },
                ),
              ],
            );
          });
        });
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
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
                  ],
                ),
              ),
            ));
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
}
