import 'dart:convert';

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

import 'dart:io' show File;
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/Images.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/ViewApplication1.dart';

class ViewApplication2 extends StatefulWidget {
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
  ViewApplication2(
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
  _ViewApplication2State createState() => _ViewApplication2State(
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

class _ViewApplication2State extends State<ViewApplication2> {
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

  _ViewApplication2State(
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

  bool flag = true;
  TextEditingController officerRemark = TextEditingController();
  TextEditingController v_reg_no = TextEditingController();
  TextEditingController D_name = TextEditingController();
  TextEditingController D_phone = TextEditingController();
  TextEditingController Transport_mode = TextEditingController();

  //---vehical---------------
  String vehical_reg_no;
  String driver_name;
  String driver_phone;
  String mode_of_transport;
  String license_image;

  var _imageLicence;
  String base64ImageLisence;

  //------pic file for remarkk----
  var _remarkfile = null;
  var filee;

  void initState() {
    super.initState();
    setState(() {
      ViewVehical();
      listDeputy();
      Range = ["mohan", "mammutti"];
    });
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

  //---end vehical-----------
  ViewVehical() async {
    String url = 'http://13.234.208.246/api/auth/ViewApplication';
    Map data = {"app_id": Ids};
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    // List list = responseJSON["data"];
    // print(list);
    print("-----------------View -Application------------");
    print(
        "------------------------------------Vehical-Details----------------------------");
    setState(() {
      if (responseJSON['data']['isvehicle'] != "Not Applicable") {
        vehical_reg_no =
            responseJSON['data']['vehicle']['vehicle_reg_no'].toString();
        driver_name = responseJSON['data']['vehicle']['driver_name'].toString();
        driver_phone =
            responseJSON['data']['vehicle']['driver_phone'].toString();
        mode_of_transport =
            responseJSON['data']['vehicle']['mode_of_transport'].toString();
        license_image =
            responseJSON['data']['vehicle']['license_image'].toString();
      }
    });
  }

  // File vehical_License_img;
  final picker = ImagePicker();
  Future<void> setfilepicgallery() async {
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageLicence = File(pickedFile.path);

        base64ImageLisence = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showpickoptiondialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setfilepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
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

  // final ImagePicker _picker = ImagePicker();
  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   //final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     vehical_License_img = pickedFile as File ;
  //     print("------------------------------Profile Image--------------");
  //     print(vehical_License_img.path);
  //   });
  // }

  //-------------------------------Assign-Officer--------------------------
  // Store the API response data
//  final picker = ImagePicker();
  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    final filee = result.files.first;
    print(result.files.first.name);
    _remarkfile = (result.files.first.name);
    print(_remarkfile);
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => ViewApplication1()),
    );
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
                          value: item['id'],
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

  //------------------------------End-Assign-Officer-----------------------
  bool can_assign_officer;
  //----------------------------Button Disable------------------------------
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
    bool transit_pass_exist = true;
    bool reject_visible = false;
    bool feild_butt = true;
    bool approve_othor = true;
    bool field_resultp = true;
    if (userGroup == 'revenue officer' && verify_officer == false) {
      transit_pass_exist = false;
      reject_visible = true;
      feild_butt = true;
      field_resultp = true;
    } else if (userGroup == 'deputy range officer') {
      feild_butt = true;
      field_resultp = true;
      if (deputy_range_officer == false) {
        transit_pass_exist = false;
        reject_visible = true;
        feild_butt = true;
        approve_othor = false;
        field_resultp = true;
      } else if (verify_officer == true && is_form_two == true) {
        print(userId);
        print(Ids);

        if (assigned_deputy2_id == userId) {
          transit_pass_exist = false;
        } else if (assigned_deputy1_id == userId && verify_deputy2 == false) {
          transit_pass_exist = false;
        }
      }
    } else if (userGroup == 'forest range officer') {
      if (is_form_two == true &&
          // field_status == "no_field" &&
          assigned_deputy1_id == null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;

        //--assign

      } else if (is_form_two == true &&
          field_status == "no_field" &&
          field_requre == "" &&
          ((assigned_deputy1_id != null) || assigned_deputy1_id != "") &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = false;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject , field assign ,remark

      }
      //    else if(is_form_two == true &&  field_status != "no_field"  && field_requre = "" && assigned_deputy1_id != null &&  verify_range_officer == false && assigned_deputy2_id == null && verify_forest1 == false ){
      //   can_assign_officer=false;
      //   feild_butt =false;
      //   field_resultp =true;
      //   reject_visible=false;
      //   approve_othor =false;
      //   transit_pass_exist=false;

      //   //approve ,reject , field assign ,remark

      // }

      else if (is_form_two == true &&
          field_status == "no_field" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = false;
        reject_visible = true;
        approve_othor = true;
        transit_pass_exist = false;

        // field accept , reject

      } else if (is_form_two == true &&
          field_status == "success" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject ,remark

      } else if (is_form_two == true &&
          field_status == "failed" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //reject ,remark

      } else if (is_form_two == true &&
          field_status == "no_field" &&
          field_requre == "" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == true) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;
        // assign ,--2

      } else if (is_form_two == true &&
          field_status != "no_field" &&
          field_requre != "" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == true) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;

        //assign--2
      } else if (is_form_two == true &&
          field_status == "success" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject  ,remark--2
      } else if (is_form_two == true &&
          field_status == "no_field" &&
          field_requre == "" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = false;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject , field assign ,remark--2
      } else if (is_form_two == true &&
          field_status == "failed" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject , field assign ,remark--2
      } else if (is_form_two == true &&
          field_status == "no_field" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = false;
        reject_visible = true;
        approve_othor = true;
        transit_pass_exist = false;

        // field accept , reject--2

      } else if (is_form_two == true &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject ,remark--2

      } else if (is_form_two == true &&
          field_status == "failed" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = true;
        transit_pass_exist = false;

        //reject ,remark--2

      } else if (is_form_two == true &&
          verify_range_officer == true &&
          assigned_deputy2_id != null &&
          verify_forest1 == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = true;
        approve_othor = true;
        transit_pass_exist = false;
      }

      ///////----FORM ONE---------

      if (is_form_two == false &&
          assigned_deputy1_id == null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = true;
        transit_pass_exist = false;
        reject_visible = true;

        //--assign

      } else if (is_form_two != true &&
          field_status == "no_field" &&
          field_requre == "" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = false;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject , field assign ,remark

      } else if (is_form_two != true &&
          field_status == "no_field" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = false;
        reject_visible = true;
        approve_othor = true;
        transit_pass_exist = false;

        // field accept , reject

      } else if (is_form_two != true &&
          field_status == "success" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //approve ,reject ,remark

      } else if (is_form_two != true &&
          field_status == "failed" &&
          field_requre == "True" &&
          assigned_deputy1_id != null &&
          verify_range_officer == false &&
          assigned_deputy2_id == null &&
          verify_forest1 == false) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = false;
        approve_othor = false;
        transit_pass_exist = false;

        //reject ,remark

      } else if (is_form_two != true && verify_range_officer == true) {
        can_assign_officer = false;
        feild_butt = true;
        field_resultp = true;
        reject_visible = true;
        approve_othor = true;
        transit_pass_exist = false;
      }
    }
    // else if(userGroup=='forest range officer') {
    //   if (verify_range_officer == false) {
    //       transit_pass_exist = false;
    //       reject_visible = true;
    //       feild_butt= false;
    //       can_assign_officer=false;

    //     }
    //     if((is_form_two == true ) && userGroup=='forest range officer' && field_requre == '' && (assigned_deputy1_id != null || assigned_deputy2_id != null)){
    //        transit_pass_exist = false;
    //        reject_visible = true;
    //        feild_butt = true;
    //        can_assign_officer=false;

    //      }
    //     if(( is_form_two == false) && userGroup=='forest range officer' && field_requre == '' && (assigned_deputy1_id != null || assigned_deputy2_id != null)){
    //        transit_pass_exist = false;
    //        reject_visible = true;
    //        can_assign_officer = false;
    //        feild_butt = true;

    //      }

    //   if ((is_form_two == true) && deputy_range_officer == false  && field_status == "no_field") {

    //     if (!(assigned_deputy1_id != null && assigned_deputy2_id != null)) {
    //       can_assign_officer = true;
    //       reject_visible = true;

    //     }
    //     if (assigned_deputy1_id != null&& verify_forest1==false){
    //       can_assign_officer=false;
    //       reject_visible = true;

    //     }
    //   }
    //   if(verify_range_officer==true ){
    //       transit_pass_exist=false;
    //       reject_visible = false;
    //       feild_butt = false;

    //       field_resultp =true;
    //       approve_othor =false;

    //   }else
    //   {
    //      if (!(assigned_deputy1_id != null && assigned_deputy2_id != null)) {
    //       can_assign_officer = true;
    //       reject_visible = true;

    //     }
    //     if (assigned_deputy1_id != null&& verify_forest1==false){
    //       can_assign_officer=true;
    //       reject_visible = true;
    //       feild_butt= true;
    //       transit_pass_exist=false;

    //     }
    //   }
    //    if((is_form_two== true || is_form_two ==false) && userGroup=='forest range officer' && field_status == "no_field" && field_requre == "True" ){
    //       transit_pass_exist=false;
    //       reject_visible = true;
    //       feild_butt = true;
    //       field_resultp = false;

    //         }
    //     else if(userGroup=='forest range officer' && field_status == "no_field"){
    //       field_resultp=true;
    //       feild_butt=false;
    //       approve_othor=false;

    //      }
    //      else if(userGroup=='forest range officer' && (field_status == "success" || field_status == "failed" )&& field_requre == "True" ){
    //       transit_pass_exist=false;
    //       approve_othor=false;
    //       reject_visible = false;
    //       feild_butt=true;

    //      }
    //       if(verify_range_officer==true ){
    //       transit_pass_exist=true;
    //       reject_visible = false;
    //       feild_butt = true;

    //       field_resultp =true;
    //       approve_othor =false;
    //       }
    //  }
    else if (userGroup == 'division officer' && division_officer == false) {
      print("----------Gsrdrtd---------");
      if (other_state == true) {
        transit_pass_exist = true;
        reject_visible = true;
        feild_butt = true;
        field_resultp = false;
      } else {
        transit_pass_exist = true;
        can_assign_officer = false;
        reject_visible = true;
        feild_butt = true;
        field_resultp = false;
      }
    }
    // else{
    //     division_officer=true;
    //     transit_pass_exist=true;
    //     reject_visible = false;
    //     feild_butt= true;
    //     field_resultp=false;
    //     approve_othor=true;
    //   print("----Testing----");

    // }
    // if (can_assign_officer == true){
    //   transit_pass_exist=true;
    //   reject_visible = false;
    //   feild_butt= false;
    // }
    print("----Testingoo----");
    print(feild_butt);
    //  --false--range1
    //  --true--range1
    //  --false--range1
    //  --false--range1
    print(field_resultp);
    print("ASSIGN $can_assign_officer");
    print(reject_visible);
    print(approve_othor);
    print(transit_pass_exist);
    return {
      'can_assign_officer': can_assign_officer,
      'transit_pass_exist': transit_pass_exist,
      'reject_visible': reject_visible,
      'feild_butt': feild_butt,
      'field_resultp': field_resultp,
      'approve_othor': approve_othor
    };
  }

  //----------------------------End Button ---------------------------------

  @override
  Widget build(BuildContext context) {
    print("---Yash----");
    print(division_officer);
    print(userGroup);
    print(field_requre);
    print(field_status);

    print(DisableButton(
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
            field_status)['can_assign_officer']
        .toString());
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: NewGradientAppBar(
            title: Text("View Application"),
            gradient: LinearGradient(
                colors: [HexColor("#26f596"), HexColor("#0499f2")]),
            elevation: 0,
            actions: [
              Container(
                padding: EdgeInsets.only(right: 15),
                child: LayoutBuilder(builder: (context, constraints) {
                  if (flag == true) {
                    return Visibility(
                        visible: (userGroup == 'user') ? true : false,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                flag = false;
                              });
                            }));
                  } else if (flag == false) {
                    return IconButton(
                        icon: Icon(
                          Icons.save_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          // final bytes = Io.File(vehical_License_img.path).readAsBytesSync();
                          // String license_Img_base= vehical_License_img.path != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
                          // print(license_Img_base);
                          const String url =
                              'http://13.234.208.246/api/auth/UpdateVehicle';
                          // print (license_Img_base);
                          Map data = {
                            "app_id": int.parse(Ids),
                            "veh_reg": v_reg_no.text,
                            "driver_name": D_name.text,
                            "phn": D_phone.text,
                            "mode": Transport_mode.text,
                            "lic_img": {
                              "type": ".png",
                              // "image": "",
                              "image": base64ImageLisence,
                            },
                            // "lic_img":license_Img_base
                          };
                          print(data);
                          var body = json.encode(data);
                          print(body);
                          // final response = await http.post(Uri.parse(url),
                          //     headers: <String, String>{
                          //       'Content-Type': 'application/json',
                          //       'Authorization': "token $sessionToken"
                          //     },
                          //     body: body);

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
                          print(responseJson);
                          setState(() {
                            flag = true;
                          });
                        });
                  }
                }),
              )
            ],
            // backgroundColor: Colors.blueGrey,

            //automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Container();
                    // if (flag == true) {
                    //   return Column(
                    //     children: <Widget>[
                    //       Padding(
                    //           padding: const EdgeInsets.only(
                    //               right: 15.0, top: 10, bottom: 0, left: 15),
                    //           child: Text(
                    //             '------VEHICLE DETAILS--------',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.black),
                    //           )),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.car_rental),
                    //           title: Text(
                    //             vehical_reg_no == null
                    //                 ? "N/A"
                    //                 : vehical_reg_no == ''
                    //                     ? "N/A"
                    //                     : vehical_reg_no,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.blue),
                    //           ),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.perm_identity_rounded),
                    //           title: Text(
                    //             driver_name == null
                    //                 ? "N/A"
                    //                 : driver_name == ''
                    //                     ? "N/A"
                    //                     : driver_name,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.blue),
                    //           ),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.phone),
                    //           title: Text(
                    //             driver_phone == null
                    //                 ? "N/A"
                    //                 : driver_phone == ''
                    //                     ? "N/A"
                    //                     : driver_phone,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.blue),
                    //           ),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.emoji_transportation),
                    //           title: Text(
                    //             mode_of_transport == null
                    //                 ? "N/A"
                    //                 : mode_of_transport == ''
                    //                     ? "N/A"
                    //                     : mode_of_transport,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.blue),
                    //           ),
                    //         ),
                    //       ),
                    //       Visibility(
                    //         visible: license_image == null ? false : true,
                    //         child: InkWell(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (_) => ImageView(
                    //                           Images: license_image.toString(),
                    //                         )));
                    //           },
                    //           child: Image.network(
                    //             license_image.toString(),
                    //             fit: BoxFit.fill,
                    //             width: 120,
                    //             height: 120,
                    //           ),
                    //         ),
                    //       )
                    //       //Container(width: 120, height: 120,child: Image.network(license_image==null?Text("Licence Image ").toString():license_image),)
                    //     ],
                    //   );
                    // }
                    //else if (flag == false) {
                    //   v_reg_no.text = vehical_reg_no;
                    //   D_name.text = driver_name;
                    //   D_phone.text = driver_phone;
                    //   Transport_mode.text = mode_of_transport;
                    //   return Column(
                    //     children: <Widget>[
                    //       Padding(
                    //           padding: const EdgeInsets.only(
                    //               right: 15.0, top: 10, bottom: 0, left: 15),
                    //           child: Text(
                    //             '------VEHICLE DETAILS--------',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.black),
                    //           )),
                    //       Container(
                    //         width: double.infinity,
                    //         margin: const EdgeInsets.only(
                    //             top: 15, left: 15, right: 15),
                    //         decoration: new BoxDecoration(
                    //             border: new Border.all(
                    //               color: Colors.grey,
                    //               width: 1,
                    //             ),
                    //             borderRadius: BorderRadius.circular(14)),
                    //         padding: const EdgeInsets.only(
                    //             left: 10.0, right: 0, top: 10, bottom: 0),
                    //         child: Row(
                    //             mainAxisSize: MainAxisSize.max,
                    //             children: <Widget>[
                    //               TextButton.icon(
                    //                 icon: Icon(Icons.image),
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     _showpickoptiondialog(context);
                    //                     //      takePhoto(ImageSource.gallery);
                    //                   });
                    //                 },
                    //                 label: Text("Upload Driver License"),
                    //               ),
                    //               Icon(
                    //                 Icons.check_circle,
                    //                 color: (_imageLicence) == null
                    //                     ? Colors.red
                    //                     : Colors.green,
                    //                 size: 28.0,
                    //               ),
                    //             ]),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.car_rental),
                    //           title: TextField(
                    //               controller: v_reg_no,
                    //               decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide(width: 2),
                    //                     borderRadius: const BorderRadius.all(
                    //                         const Radius.circular(14.0)),
                    //                   ),
                    //                   labelText: 'Vechcle Reg No',
                    //                   hintText: vehical_reg_no),
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.blue)),
                    //           // TextField(
                    //           //   controller: v_reg_no,
                    //           //   decoration: InputDecoration(
                    //           //       border: InputBorder.none,
                    //           //       hintText: vehical_reg_no),
                    //           //   style: TextStyle(
                    //           //       fontWeight: FontWeight.bold,
                    //           //       color: Colors.blue),
                    //           // ),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.perm_identity_rounded),
                    //           // title: TextField(
                    //           //   controller: D_name,
                    //           //   decoration: InputDecoration(
                    //           //       border: InputBorder.none,
                    //           //       hintText: driver_name.toString()),
                    //           //   style: TextStyle(
                    //           //       fontWeight: FontWeight.bold,
                    //           //       color: Colors.blue),
                    //           // ),
                    //           title: TextField(
                    //               controller: D_name,
                    //               decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide(width: 2),
                    //                     borderRadius: const BorderRadius.all(
                    //                         const Radius.circular(14.0)),
                    //                   ),
                    //                   labelText: 'Driver Name',
                    //                   hintText: driver_name.toString()),
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.blue)),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.phone),
                    //           title: TextField(
                    //               controller: D_phone,
                    //               //  keyboardType: TextInputType.number,
                    //               decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide(width: 2),
                    //                     borderRadius: const BorderRadius.all(
                    //                         const Radius.circular(14.0)),
                    //                   ),
                    //                   labelText: 'Phone ',
                    //                   hintText: driver_phone),
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.blue)),

                    //           //  TextField(
                    //           //   controller: D_phone,
                    //           //   keyboardType: TextInputType.number,
                    //           //   decoration: InputDecoration(
                    //           //       border: InputBorder.none,
                    //           //       hintText: driver_phone),
                    //           //   style: TextStyle(
                    //           //       fontWeight: FontWeight.bold,
                    //           //       color: Colors.blue),
                    //           // ),
                    //         ),
                    //       ),
                    //       Card(
                    //         child: ListTile(
                    //           leading: Icon(Icons.emoji_transportation),
                    //           title: TextField(
                    //               controller: Transport_mode,
                    //               decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderSide: BorderSide(width: 2),
                    //                     borderRadius: const BorderRadius.all(
                    //                         const Radius.circular(14.0)),
                    //                   ),
                    //                   labelText: 'transport model',
                    //                   hintText: mode_of_transport.toString()),
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.blue)),
                    //           // TextField(
                    //           //   controller: Transport_mode,
                    //           //   decoration: InputDecoration(
                    //           //       border: InputBorder.none,
                    //           //       hintText: mode_of_transport.toString()),
                    //           //   style: TextStyle(
                    //           //       fontWeight: FontWeight.bold,
                    //           //       color: Colors.blue),
                    //           // ),
                    //         ),
                    //       ),
                    //     ],
                    //   );
                    // }
                  }),
                ),
                Visibility(
                    visible: can_assign_officer,
                    // visible: DisableButton(
                    //             userGroup,
                    //             verify_officer,
                    //             deputy_range_officer,
                    //             verify_range_officer,
                    //             is_form_two,
                    //             userId,
                    //             assigned_deputy2_id,
                    //             assigned_deputy1_id,
                    //             verify_deputy2,
                    //             division_officer,
                    //             other_state,
                    //             verify_forest1,
                    //             field_requre,
                    //             field_status)['can_assign_officer'] ==
                    //         true
                    //     ? false
                    //     : true,
                    child: ElevatedButton(
                      //  color: Colors.orange,
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
                    child: Column(children: <Widget>[
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
                    ])),
                LayoutBuilder(builder: (context, constraints) {
                  if (userGroup == 'user') {
                    return Container(
                      width: 0,
                      height: 0,
                      color: Colors.white,
                    );
                  } else if (userGroup == 'state officer') {
                    return Container(
                      width: 0,
                      height: 0,
                      color: Colors.white,
                    );
                  } else {
                    return Visibility(
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
                                  field_status)['transit_pass_exist'] ==
                              false
                          ? true
                          : false,
                      child: Container(
                          child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, top: 15, left: 15, bottom: 0),
                          child: Visibility(
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
                                        field_status)["approve_othor"] ==
                                    false
                                ? true
                                : false,
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 0, top: 10, bottom: 0),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    TextButton.icon(
                                      icon: Icon(Icons.file_upload_sharp),
                                      onPressed: () {
                                        _pickFile();
                                      },
                                      label: Text("Add remarks"),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Container(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Visibility(
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
                                          field_status)["approve_othor"] ==
                                      false
                                  ? true
                                  : false,
                              child: ElevatedButton(
                                child: Text(
                                  'Approve',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () async {
                                  if ((_remarkfile == null)) {
                                    Fluttertoast.showToast(
                                        msg: "Please fill Remark feild",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else {
                                    const String url =
                                        'http://13.234.208.246/api/auth/new_approve_transit_pass';
                                    Map data = {
                                      "app_id": Ids,
                                      "type": "Approve",
                                      "reason": _remarkfile,
                                    };
                                    print(data);
                                    var body = json.encode(data);
                                    print(body);
                                    final response = await http.post(
                                        Uri.parse(url),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json',
                                          'Authorization': "token $sessionToken"
                                        },
                                        body: body);
                                    Map<String, dynamic> responseJson =
                                        json.decode(response.body);
                                    print(
                                        "----------------Officer Remark-----------------------");
                                    print(responseJson);
                                    Fluttertoast.showToast(
                                        msg: responseJson['message'].toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 8,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OfficerDashboard(
                                                  sessionToken: sessionToken,
                                                  userName: userName,
                                                  userEmail: userEmail,
                                                  userGroup: userGroup,
                                                )));
                                  }
                                },
                                // color: Colors.blueAccent,
                                // textColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Visibility(
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
                                          field_status)["reject_visible"] ==
                                      false
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      child: Text(
                                        'Reject',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        if ((_remarkfile == null)) {
                                          Fluttertoast.showToast(
                                              msg: "Please fill Remark feild",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 4,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                        } else {
                                          const String url =
                                              'http://13.234.208.246/api/auth/approve_transit_pass';
                                          Map data = {
                                            "app_id": Ids,
                                            "type": "REJECT",
                                            "reason": _remarkfile,
                                          };
                                          print(data);
                                          var body = json.encode(data);
                                          print(body);
                                          final response = await http.post(
                                              Uri.parse(url),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json',
                                                'Authorization':
                                                    "token $sessionToken"
                                              },
                                              body: body);
                                          Map<String, dynamic> responseJson =
                                              json.decode(response.body);
                                          print(
                                              "----------------Officer Remark-----------------------");
                                          print(responseJson);
                                          Fluttertoast.showToast(
                                              msg: responseJson['message']
                                                  .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 8,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      OfficerDashboard(
                                                        sessionToken:
                                                            sessionToken,
                                                        userName: userName,
                                                        userEmail: userEmail,
                                                        userGroup: userGroup,
                                                      )));
                                        }
                                      },
                                      // color: Colors.red,
                                      // textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Visibility(
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
                                          field_status)["field_resultp"] ==
                                      false
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green)),
                                      child: Text(
                                        'Field officer approved',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () async {
                                        {
                                          const String url =
                                              'http://13.234.208.246/api/auth/success_field_verification';
                                          Map data = {
                                            "app_id": Ids,
                                            "type": "success",
                                          };
                                          print(data);
                                          var body = json.encode(data);
                                          print(body);
                                          final response = await http.post(
                                              Uri.parse(url),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json',
                                                'Authorization':
                                                    "token $sessionToken"
                                              },
                                              body: body);
                                          Map<String, dynamic> responseJson =
                                              json.decode(response.body);
                                          print(
                                              "----------------Officer Remark-----------------------");
                                          print(responseJson);
                                          Fluttertoast.showToast(
                                              msg: responseJson['message']
                                                  .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 8,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      OfficerDashboard(
                                                        sessionToken:
                                                            sessionToken,
                                                        userName: userName,
                                                        userEmail: userEmail,
                                                        userGroup: userGroup,
                                                      )));
                                        }
                                      },
                                      // color: Colors.red,
                                      // textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Visibility(
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
                                          field_status)["field_resultp"] ==
                                      false
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red)),
                                      child: Text(
                                        'Field officer reject',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () async {
                                        {
                                          const String url =
                                              'http://13.234.208.246/api/auth/failed_field_verification';
                                          Map data = {
                                            "app_id": Ids,
                                            "type": "failed",
                                          };
                                          print(data);
                                          var body = json.encode(data);
                                          print(body);
                                          final response = await http.post(
                                              Uri.parse(url),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json',
                                                'Authorization':
                                                    "token $sessionToken"
                                              },
                                              body: body);
                                          Map<String, dynamic> responseJson =
                                              json.decode(response.body);
                                          print(
                                              "----------------Officer Remark-----------------------");
                                          print(responseJson);
                                          Fluttertoast.showToast(
                                              msg: responseJson['message']
                                                  .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 8,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      OfficerDashboard(
                                                        sessionToken:
                                                            sessionToken,
                                                        userName: userName,
                                                        userEmail: userEmail,
                                                        userGroup: userGroup,
                                                      )));
                                        }
                                      },
                                      // color: Colors.red,
                                      // textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Visibility(
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
                                          field_status)["feild_butt"] ==
                                      false
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ElevatedButton(
                                      child: Text(
                                        'Field enquiry',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        {
                                          const String url =
                                              'http://13.234.208.246/api/auth/need_field_verification';
                                          Map data = {
                                            "app_id": Ids,
                                            "type": "True",
                                          };
                                          print(data);
                                          var body = json.encode(data);
                                          print(body);
                                          final response = await http.post(
                                              Uri.parse(url),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json',
                                                'Authorization':
                                                    "token $sessionToken"
                                              },
                                              body: body);
                                          Map<String, dynamic> responseJson =
                                              json.decode(response.body);
                                          print(
                                              "----------------Officer Remark-----------------------");
                                          print(responseJson);
                                          Fluttertoast.showToast(
                                              msg: responseJson['message']
                                                  .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 8,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      OfficerDashboard(
                                                        sessionToken:
                                                            sessionToken,
                                                        userName: userName,
                                                        userEmail: userEmail,
                                                        userGroup: userGroup,
                                                      )));
                                        }
                                      },
                                      // color: Colors.red,
                                      // textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ])),
                      ])),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
