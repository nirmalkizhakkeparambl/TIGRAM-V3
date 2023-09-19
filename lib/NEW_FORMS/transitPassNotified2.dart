import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../homePage.dart';

class transitPassNotified2 extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String Name_;
  String Division_;
  String range_;
  String address_;
  String survey_no_;
  String tree_no_cut;
  String district_;
  String taluke_;
  String block_;
  String village_;
  String pincode_;
  List holder_1;
  String purpose_;
  List log_details;

  transitPassNotified2(
      {this.formOneIndex,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name_,
      this.Division_,
      this.range_,
      this.address_,
      this.survey_no_,
      this.tree_no_cut,
      this.district_,
      this.taluke_,
      this.block_,
      this.village_,
      this.pincode_,
      this.holder_1,
      this.purpose_,
      this.log_details});

  @override
  State<transitPassNotified2> createState() => _transitPassNotified2State(
      formOneIndex,
      sessionToken,
      userName,
      userEmail,
      userId,
      Name_,
      Division_,
      range_,
      address_,
      survey_no_,
      tree_no_cut,
      district_,
      taluke_,
      block_,
      village_,
      pincode_,
      holder_1,
      purpose_,
      log_details);
}

class _transitPassNotified2State extends State<transitPassNotified2> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String Name_;
  String Division_;
  String range_;
  String address_;
  String survey_no_;
  String tree_no_cut;
  String district_;
  String taluke_;
  String block_;
  String village_;
  String pincode_;
  List holder_1;
  String purpose_;
  List log_details;
  bool isDeclarationChecked = false;
  TextEditingController id_no = TextEditingController();
  String dropdownValue2;
  String holder = '';
  List<String> IdProof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];
  String selectedPRoof;
  bool isShow = false;

  _transitPassNotified2State(
      this.formOneIndex,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name_,
      this.Division_,
      this.range_,
      this.address_,
      this.survey_no_,
      this.tree_no_cut,
      this.district_,
      this.taluke_,
      this.block_,
      this.village_,
      this.pincode_,
      this.holder_1,
      this.purpose_,
      this.log_details);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: NewGradientAppBar(
              // backgroundColor: Colors.blueGrey,
              title: Text("Form II - Notified"),
              gradient: LinearGradient(
                  colors: [HexColor("#26f596"), HexColor("#0499f2")]),
              elevation: 0,
              // automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10, bottom: 0),
                              child: DropdownButton<String>(
                                value: dropdownValue2,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                hint: Text("Select Photo Identity Proof"),
                                onChanged: (String data) {
                                  setState(() {
                                    dropdownValue2 = data;
                                    selectedPRoof = dropdownValue2;
                                  });
                                  print(selectedPRoof);
                                },
                                items: IdProof.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: (() {
                                      flag1 = true;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = false;
                                      if (flag1) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: Text("Upload Photo ID Proof or PDF"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imageIDProof != null ||
                                            _pdfIDProof != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10, bottom: 0),
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: id_no,
                                //  obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(14.0)),
                                    ),
                                    labelText: 'ID Number',
                                    hintText: ' Enter ID Number '),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: (() {
                                      flag1 = false;
                                      flag2 = true;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = false;
                                      if (flag2) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: Text("Upload Land Tax Proof"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imglandTax != null ||
                                            _pdfLandTax != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: (() {
                                      flag1 = false;
                                      flag2 = false;
                                      flag3 = true;
                                      flag4 = false;
                                      flag5 = false;
                                      if (flag3) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: Text("Upload Digital Signature"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imgDigiSignature != null ||
                                            _pdfDigiSignature != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: (() {
                                      flag1 = false;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = true;
                                      flag5 = false;
                                      if (flag4) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: Text("Upload Proof of Ownership"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imgProofOwner != null ||
                                            _pdfProofOwner != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: (() {
                                      flag1 = false;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = true;
                                      if (flag5) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label:
                                        Text("Upload Possession certificate"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imgPossession != null ||
                                            _pdfPossession != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: isDeclarationChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isDeclarationChecked = value;
                                        if (value) {
                                          _showDeclarationPopup(); // Show the popup when the checkbox is checked
                                        }
                                      });
                                    },
                                  ),
                                  const Text('DECLARATION'),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: isShow,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                strokeWidth: 8,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, bottom: 0.0),
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {
                                    isShow = true;
                                  });
                                  const String url =
                                      'http://13.234.208.246/api/auth/new_application_form/';
                                  Map data = {
                                    "name": Name_,
                                    "address": address_,
                                    "survey_no": survey_no_,
                                    "tree_proposed": tree_no_cut,
                                    "village": village_,
                                    "district": district_,
                                    "block": block_,
                                    "taluka": taluke_,
                                    "division": Division_,
                                    "area_range": range_,
                                    "pincode": pincode_,
                                    "tree_species": holder_1.toString(),
                                    "is_form_two": "1",
                                    "purpose_cut": purpose_,
                                    "ownership_proof_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      "src": OWNER_PROOF
                                      //"src": ""
                                    },
                                    "revenue_application_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      "src": ""
                                    },
                                    "revenue_approval_img": {
                                      "type": "file",
                                      // "src": ""
                                      "mime": "image/jpeg",
                                      "src": LAND_PROOF
                                    },
                                    "declaration_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      // "src": ""
                                      "src": POSSESSION
                                    },
                                    "tree_ownership_img": {
                                      "type": "file",
                                      "src": ""
                                    },
                                    "location_sketch_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      "src": ""
                                    },
                                    "aadhar_card_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      "src": ID_PROOF
                                      // "src": ""
                                    },
                                    "signature_img": {
                                      "type": "file",
                                      "mime": "image/jpeg",
                                      // "src": ""
                                      "src": DIGI_SIGN
                                    },
                                    "log_details": log_details ?? ""
                                  };

                                  print(data);
                                  var body = json.encode(data);
                                  print(body);
                                  final response = await http.post(
                                      Uri.parse(url),
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
                                  if (responseJson['status'] != "success") {
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
                                      msg: "Application Sumbitted",
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
                                          transitionsBuilder: (context,
                                              animation, animationTime, child) {
                                            return ScaleTransition(
                                              alignment: Alignment.topCenter,
                                              scale: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                              animationTime) {
                                            return HomePage(
                                                sessionToken: sessionToken,
                                                userName: userName,
                                                userEmail: userEmail,
                                                userId: userId);
                                          }));
                                },
                                child: Text(
                                  ' APPLY FOR CUTTING ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontFamily: 'Cairo',
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _showDeclarationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms & Conditions'),
          content: Text(
              'I hereby declare that the information furnished above is true to the best of my knowledge and belief. I also undertake to comply with the conditions subject to which the permission may be granted by the Authorised officer'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Uncheck the checkbox when "Cancel" is pressed
                setState(() {
                  isDeclarationChecked = false;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Mark the checkbox as checked when "Agree" is pressed
                setState(() {
                  isDeclarationChecked = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Agree'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Do you want to go previous page'),
            content: new Text('Changes you made may not be saved.'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  File _imageIDProof;
  File _pdfIDProof;
  File _imglandTax;
  File _pdfLandTax;
  File _imgDigiSignature;
  File _pdfDigiSignature;
  File _imgProofOwner;
  File _pdfProofOwner;
  File _imgPossession;
  File _pdfPossession;

  String ID_PROOF = "";
  String LAND_PROOF = "";
  String DIGI_SIGN = "";
  String OWNER_PROOF = "";
  String POSSESSION = "";

  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  bool flag4 = false;
  bool flag5 = false;

  Future<void> _pickImageOrPDF() async {
    final picker = ImagePicker();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(); // Close the dialog
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null && result.files.isNotEmpty) {
                          final fileBytes = result.files.first.bytes;
                          setState(() {
                            if (flag1) {
                              _pdfIDProof = File(result.files.single.path);
                              ID_PROOF = base64Encode(fileBytes);
                            } else if (flag2) {
                              _pdfLandTax = File(result.files.single.path);
                              LAND_PROOF = base64Encode(fileBytes);
                            } else if (flag3) {
                              _pdfDigiSignature =
                                  File(result.files.single.path);
                              DIGI_SIGN = base64Encode(fileBytes);
                            } else if (flag4) {
                              _pdfProofOwner = File(result.files.single.path);
                              OWNER_PROOF = base64Encode(fileBytes);
                            } else if (flag5) {
                              _pdfPossession = File(result.files.single.path);
                              POSSESSION = base64Encode(fileBytes);
                            }
                          });
                        }
                      },
                      splashColor: Colors.blueAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.picture_as_pdf_sharp,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'PDF',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(); // Close the dialog
                        final pickedImage =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          String temp =
                              base64Encode(await pickedImage.readAsBytes());
                          setState(() {
                            if (flag1) {
                              _imageIDProof = File(pickedImage.path);
                              ID_PROOF = temp;
                            } else if (flag2) {
                              _imglandTax = File(pickedImage.path);
                              LAND_PROOF = temp;
                            } else if (flag3) {
                              _imgDigiSignature = File(pickedImage.path);
                              DIGI_SIGN = temp;
                            } else if (flag4) {
                              _imgProofOwner = File(pickedImage.path);
                              OWNER_PROOF = temp;
                            } else if (flag5) {
                              _imgPossession = File(pickedImage.path);
                              POSSESSION = temp;
                            }
                          });
                        }
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
}
