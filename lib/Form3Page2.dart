import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as Io;

class Form3Page2 extends StatefulWidget {
  String Name;
  String Address;
  List log_details;
  String sessionToken;
  String Ids1;
  Form3Page2(
      {this.sessionToken,
      this.Ids1,
      this.Name,
      this.Address,
      this.log_details});
  @override
  _Form3Page2State createState() =>
      _Form3Page2State(sessionToken, Ids1, Name, Address, log_details);
}

class _Form3Page2State extends State<Form3Page2> {
  String Name;
  String Address;
  List log_details;
  String sessionToken;
  String Ids1;
  _Form3Page2State(
      this.sessionToken, this.Ids1, this.Name, this.Address, this.log_details);

  TextEditingController Marks = TextEditingController();
  TextEditingController Whence = TextEditingController();
  TextEditingController Route = TextEditingController();
  TextEditingController Time = TextEditingController();
  TextEditingController Remarks = TextEditingController();
  TextEditingController destination = TextEditingController();
  File _Signature;
  final ImagePicker _picker1 = ImagePicker();
  var _imageSignature;
  String base64ImageSignature = 'empty';
  // void Signature(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _Signature = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Signature.path);
  //   });
  // }

  final picker = ImagePicker();
  Future<void> setSignaturepicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSignature = File(pickedFile.path);

        base64ImageSignature = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showpickoptiondialogSignature(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setSignaturepicgallery();
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
                  ],
                ),
              ),
            ));
  }

  // String ImageSignature() {
  //   final bytes7 = Io.File(_Signature.path).readAsBytesSync();
  //   String sign_base = _Signature.path != null
  //       ? 'data:image/png;base64,' + base64Encode(bytes7)
  //       : '';
  //   print('------------8--------------');
  //   print(sign_base);
  //   return sign_base;
  // }

  //-------------------------------Progress bar---------------------------------
  bool isShow = false;
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    const String url = 'http://13.234.208.246api/auth/FormThree';
    Map data = {
      "app_id": int.parse(Ids1),
      "marks": Marks.text,
      "whence_obtained": Whence.text,
      "destination": destination.text,
      "time_allowed": Time.text,
      "route": Route.text,
      "remarks": Remarks.text,
      "forest_sign": {
        "type": ".png",
        "image": base64ImageSignature,
      },
    };
    print(data);
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("----------------Form -3 -----------------------");
    print(responseJson);
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
    isShow == true ? CircularProgressIndicator() : Text('done');
    return true;
  }

  //------------------------------End-Progress-Bar------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          "FORM - III",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        //backgroundColor: ColorLinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        gradient:
            LinearGradient(colors: [HexColor("#26f596"), HexColor("#0499f2")]),
        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Marks,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Marks',
                    hintText: 'Enter Marks'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Whence,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Whence Obtained',
                    hintText: 'Enter Whence Obtained'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: destination,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Destination',
                    hintText: 'Enter Destination'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Route,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Route',
                    hintText: 'Enter Route of Forest Watch Station'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Time,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Time Allowed (In days)',
                    hintText: 'Enter Time Allowed (In days)'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Remarks,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(14.0)),
                    ),
                    labelText: 'Remarks',
                    hintText: 'Enter Remarks'),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 15, right: 15, left: 15, bottom: 10),
              decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    _showpickoptiondialogSignature(
                        context); //      Signature(ImageSource.gallery);
                    //  print(_Signature.path);
                  },
                  label: Text("Signature"),
                ),
                Spacer(),
                Icon(
                  Icons.check_circle,
                  color: (_imageSignature) == null ? Colors.red : Colors.green,
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellowAccent,
              ),
              onPressed: () async {
                setState(() {
                  isShow = true;
                });
                await loginAction();
                // Respond to button press
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
            ),
            /*RaisedButton(
              color: Colors.yellow,
              onPressed:() async {
                final String url = 'http://65.1.132.43:8080/api/auth/FormThree';
                Map data={
                  "app_id":Ids1,
                  "marks":Marks.text,
                  "whence_obtained":Whence.text,
                  "destination":destination.text,
                  "time_allowed":Time.text,
                  "route":Route.text,
                  "remarks":Remarks.text,
                  "forest_sign":{
                    "type": ".png",
                    "image":ImageSignature(),
                  },
                };
                print(data);
                var body = json.encode(data);
                print(body);
                var response = await http.post(url,
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': "token $sessionToken"
                    },
                    body: body);
                Map<String, dynamic> responseJson = json.decode(response.body);
                print("----------------Form -3 -----------------------");
                print(responseJson);
                Fluttertoast.showToast(msg: responseJson['message'].toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 8,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 18.0);
              },
              child: Text('Submit'),)*/
          ],
        ),
      ),
    );
  }
}
