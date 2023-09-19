import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/CheckPassStatus.dart';
import 'package:tigramnks/Form2Page1.dart';
import 'package:tigramnks/Help.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNonNot.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNotified.dart';
import 'package:tigramnks/NEW_FORMS/transitView.dart';
import 'package:tigramnks/Profile.dart';
import 'package:tigramnks/QueryPage.dart';
import 'package:tigramnks/TransitForms.dart';
import 'package:tigramnks/acknowlegeUser.dart';
import 'package:tigramnks/itgramWoodBuy.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/noc_Form.dart';
import 'package:tigramnks/tigramWoodShed.dart';
import 'package:tigramnks/woodBuyerForm.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'TransitPass.dart';

class VillageData {
  final int id;
  final String villageName;
  final bool isNotified;

  VillageData({
    this.id,
    this.villageName,
    this.isNotified,
  });

  factory VillageData.fromJson(Map<String, dynamic> json) {
    return VillageData(
      id: json['id'],
      villageName: json['village_name'],
      isNotified: json['is_notified'],
    );
  }
}

class HomePage extends StatefulWidget {
  String sessionToken;
  int userId;
  String userName;
  String userMobile;
  String userEmail;
  String userAddress;
  String userProfile;
  String userGroup;
  String userCato;
  HomePage(
      {this.sessionToken,
      this.userId,
      this.userName,
      this.userEmail,
      this.userMobile,
      this.userAddress,
      this.userProfile,
      this.userGroup,
      this.userCato});

  @override
  _HomePageState createState() => _HomePageState(sessionToken, userId, userName,
      userEmail, userMobile, userAddress, userProfile, userGroup, userCato);
}

class _HomePageState extends State<HomePage> {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userMobile;
  String userAddress;
  String userProfile;
  String userGroup;
  String userCato;
  _HomePageState(
      this.sessionToken,
      this.userId,
      this.userName,
      this.userEmail,
      this.userMobile,
      this.userAddress,
      this.userProfile,
      this.userGroup,
      this.userCato);

  bool _showPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Tigram"),
        gradient:
            LinearGradient(colors: [HexColor("#26f596"), HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(children: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return YourDialog(
                      sessionToken: sessionToken,
                      userId: userId,
                      userName: userName,
                      userMail: userEmail);
                },
              );
            },
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (_) => TransitForms(
            //           sessionToken: sessionToken,
            //           userName: userName,
            //           userEmail: userEmail,
            //           userId: userId),
            //     ),
            //   );
            // },

            child: Container(
                // width: 310,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(
                    top: 25.0, left: 20, right: 20, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: <Widget>[
                  Container(
                    child: new Image.asset(
                      'assets/images/apply_icon.png',
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Apply for Cutting / \n Transit Pass',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ])),
          ),
          InkWell(
            splashColor: Colors.white70,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckPassStatus(
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userEmail,
                      userGroup: userGroup,
                      userId: userId),
                ),
              );

              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => CheckPassStatus(
              //             sessionToken: sessionToken,
              //             userName: userName,
              //             userEmail: userEmail,
              //             userGroup: userGroup,
              //             userId: userId)));
            },
            hoverColor: Colors.blueGrey,
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(
                    top: 8, left: 20, right: 20, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: <Widget>[
                  Container(
                    child: new Image.asset(
                      'assets/images/check_status.png',
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Check Pass Status',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  )
                ])),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NocForm(
                        sessionToken: sessionToken,
                        userName: userName,
                        userEmail: userEmail,
                        userId: userId),
                  ),
                );

                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => NocForm(
                //             sessionToken: sessionToken,
                //             userName: userName,
                //             userEmail: userEmail,
                //             userId: userId)));
              },
              hoverColor: Colors.blueGrey,
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 8.0, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.sticky_note_2,
                        size: MediaQuery.of(context).size.height * 0.12,
                        color: Colors.white,
                      ),
                      /*child:new Image.asset(
                          'assets/images/question_icon.png',
                          height: 125,
                        ),*/
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'NOC For Exempted Species',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ]))),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => acknowUser(
                      userId: userId,
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userEmail,
                      userGroup: userGroup,
                    ),
                  ),
                );
              },
              hoverColor: Color.fromARGB(255, 26, 189, 17),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 8.0, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 185, 30, 144),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.ads_click_outlined,
                        size: MediaQuery.of(context).size.height * 0.12,
                        color: Colors.white,
                      ),
                      /*child:new Image.asset(
                          'assets/images/question_icon.png',
                          height: 125,
                        ),*/
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'My Acknowledgement',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ]))),
          InkWell(
              onTap: selectType,
              hoverColor: Colors.blueGrey,
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 8.0, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 15, 143, 55),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.sell,
                        size: MediaQuery.of(context).size.height * 0.12,
                        color: Colors.white,
                      ),
                      /*child:new Image.asset(
                          'assets/images/question_icon.png',
                          height: 125,
                        ),*/
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Tigram Woodshed',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ]))),
        ]),
      )),
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#26f596"), HexColor("#0499f2")]),
                  ),
                  accountEmail: Text('$userEmail'),
                  accountName: Text('$userName'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      userName[0].toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.perm_identity,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Profile(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userEmail,
                                  userMobile: userMobile,
                                  userAddress: userAddress,
                                  userProfile: userProfile)));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      print(sessionToken);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HomePage(
                                    sessionToken: sessionToken,
                                    userName: userName,
                                    userEmail: userEmail,
                                    userMobile: userMobile,
                                    userAddress: userAddress,
                                    userProfile: userProfile,
                                    userGroup: userGroup,
                                  )));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'QR-Scanner',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => QueryPage()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.help,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Help',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Help()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () async {
                      const String url =
                          'http://13.234.208.246/api/auth/logout/';
                      await http.post(
                        Uri.parse(url),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Authorization': "token $sessionToken"
                        },
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => login()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String usertCat = "";
  void selectType() async {
    const String url = 'http://13.234.208.246api/auth/check_usr_category';
    Map data = {"id": userId};
    print(data);
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    print(response.body);

    Map<String, dynamic> responseJson = json.decode(response.body);
    setState(() {
      usertCat = responseJson["data"][0]["usr_category"];
    });
    print(usertCat);
    if (usertCat == "no_data") {
      _onBackPressed();
    } else if (usertCat == "individual" || usertCat == "firm") {
      _onBackPressed();
    }
  }

  Future<bool> _onBackPressed() {
    print(userCato);
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Select the User type'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Visibility(
                  visible: usertCat.contains("no_data"),
                  child: ListTile(
                    // leading: Icon(Icons.box),
                    title: Text("Buyer"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => woodBuyerForm(
                                  userId: userId,
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userEmail,
                                  userCato: "buyer")));
                    },
                  ),
                ),
                Divider(),
                Visibility(
                  visible: usertCat != "no_data",
                  child: ListTile(
                    // leading: Icon(Icons.check_box),
                    title: Text("Buyer"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => tigramWoodBuy(
                                    userId: userId,
                                    sessionToken: sessionToken,
                                    userName: userName,
                                    userEmail: userEmail,
                                    userCato: "buyer",
                                  )));
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text("Seller"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => tigramWoodShed(
                                userId: userId,
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userEmail)));
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ) ??
        false;
  }
}

class YourDialog extends StatefulWidget {
  final String sessionToken;
  final int userId;
  final String userName;
  final String userMail;

  YourDialog({
    this.sessionToken,
    this.userId,
    this.userName,
    this.userMail,
  });
  @override
  _YourDialogState createState() =>
      _YourDialogState(sessionToken, userName, userMail, userId);
}

class _YourDialogState extends State<YourDialog> {
  String sessionToken;
  String userName;
  String userMail;
  int userId;

  List<VillageData> villages = [];
  bool _showPopup = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  _YourDialogState(
      this.sessionToken, this.userName, this.userMail, this.userId);

  TextEditingController _searchController = TextEditingController();
  String _selectedVillage = '';
  int _selectedVillageId = 0;
  bool _isNotified;

  List<String> _suggestions = [];
  String _selectedForm = '';
  String _selectedField = '';
  String _speciasContain = "";

  bool _showTextField = false;
  bool _showTextField_C = false;
  bool _showSpecias = false;
  final List<String> speciasTextList = [
    "Coconut",
    "Rubber",
    "Cashew",
    "Tamarind",
    "Mango",
    "Jack Fruit Tree",
    "Kodampuli",
    "Matti",
    "Arecanut",
    "Konna",
    "Seema Konna",
    "Nelli",
    "Neem",
    "Murukku",
    "Jathi",
    "Albezia",
    "Silk Cotton",
    "Acacia auraculiformis",
    "Mangium",
    "Anhili",
    "Kilimaram",
    "Manchadimaram",
    "Vatta",
    "Palm tree",
    "Aranamaram",
    "Eucalyptus",
    "Seemaplavu",
    "Paala"
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side:
            const BorderSide(color: Colors.greenAccent), // Set the border color
      ),
      title: const Text('FORM SELECTION'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile(
              title: const Text('Cutting Permission'),
              value: 'cutting',
              groupValue: _selectedForm,
              onChanged: (value) {
                setState(() {
                  _selectedForm = value;
                  print(_selectedForm);
                  _showTextField = false;
                  _showTextField_C = true;
                });
              },
            ),
            RadioListTile(
              title: const Text('Transit Pass'),
              value: 'transit',
              groupValue: _selectedForm,
              onChanged: (value) {
                setState(() {
                  _selectedForm = value;
                  print(_selectedForm);
                  _showTextField = true;
                  _showTextField_C = false;
                });
              },
            ),
            const SizedBox(height: 18),
            if (_showTextField_C)
              Column(
                children: [
                  const Text(
                      " Whether your land falls under \nCardamom / Coffiee plantation ? "),
                  const SizedBox(height: 13),
                  // Row(
                  //   children: [
                  RadioListTile(
                    title: const Text('Yes'),
                    value: 'yes',
                    groupValue: _selectedField,
                    onChanged: (value) {
                      setState(() {
                        _selectedField = value;
                        print(_selectedField);
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('No'),
                    value: 'no',
                    groupValue: _selectedField,
                    onChanged: (value) {
                      setState(() {
                        _selectedField = value;
                        print(_selectedField);

                        // _showPopupMessageField(context);
                      });
                    },
                  ),
                  //   ],
                  // ),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _selectedVillage = '';
                        _suggestions = getSuggestions(value, villages);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a village...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showSuggestionsDialog(context, villages);
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (_showSpecias)
                    Container(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: speciasTextList
                              .map((text) => ListTile(title: Text(text)))
                              .toList(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (_showSpecias)
                    const Text("Is your specias are in the above list ? "),
                  if (_showSpecias) const SizedBox(height: 13),
                  if (_showSpecias)
                    RadioListTile(
                      title: const Text('Yes'),
                      value: 'yes',
                      groupValue: _speciasContain,
                      onChanged: (value) {
                        setState(() {
                          _speciasContain = value;
                          print(_speciasContain);
                          _showPopupMessage(context);
                        });
                      },
                    ),
                  if (_showSpecias)
                    RadioListTile(
                      title: const Text('No'),
                      value: 'no',
                      groupValue: _speciasContain,
                      onChanged: (value) {
                        setState(() {
                          _speciasContain = value;
                          print(_speciasContain);
                        });
                      },
                    ),

                  ElevatedButton(
                    onPressed: () {
                      if (_selectedForm == "") {
                        Fluttertoast.showToast(
                            msg: "Please select application type ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      }
                      if (_selectedForm == "cutting") {
                        if (_selectedField == "") {
                          Fluttertoast.showToast(
                              msg: "Please select land type ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        }
                      }
                      if (_selectedVillageId == 0) {
                        Fluttertoast.showToast(
                            msg: "Please select village ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      }

                      if (_selectedForm == "cutting" &&
                          _selectedVillageId != 0 &&
                          _selectedField == "yes" &&
                          _isNotified == false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => transitPassNotified(
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userMail,
                                userId: userId,
                                village_: _selectedVillage),
                          ),
                        );
                      } else if (_selectedForm == "cutting" &&
                          _selectedVillageId != 0 &&
                          _selectedField == "yes" &&
                          _isNotified == true &&
                          _speciasContain == "no") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => transitPassNotified(
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userMail,
                                userId: userId),
                          ),
                        );
                      }
                      //// Yes for plantation-- will go F2
                      else if (_selectedForm == "cutting" &&
                          _selectedVillageId != 0 &&
                          _selectedField == "yes" &&
                          _isNotified == true &&
                          _speciasContain == "yes") {
                        Fluttertoast.showToast(
                            msg: "No need of Transit pass",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      }

                      //// Yes for plantation--and Yes for specias  -- Toast

                      else if (_selectedForm == "cutting" &&
                          _selectedVillageId != 0 &&
                          _selectedField == "no" &&
                          _isNotified == true &&
                          _speciasContain == "no") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => transitPassNotified(
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userMail,
                                userId: userId,
                                village_: _selectedVillage),
                          ),
                        );
                      } else if (_selectedForm == "cutting" &&
                          _selectedVillageId != 0 &&
                          _selectedField == "no" &&
                          _isNotified == false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => transitPassNonNotified(
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userMail,
                                userId: userId,
                                village_: _selectedVillage),
                          ),
                        );
                      }
                    },
                    child: const Text('NEXT'),
                  ),
                ],
              ),
            if (_showTextField)
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Cutting ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius as needed
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Set the background color
                    ),
                  ),
                  const SizedBox(height: 18),
                  // TextField(
                  //   controller: _searchController,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedVillage =
                  //           ''; // Clear selected value when typing
                  //       _suggestions = getSuggestions(value, villages);
                  //     });
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'Search for a village...',
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 12.0, horizontal: 16.0),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     suffixIcon: IconButton(
                  //       onPressed: () {
                  //         _showSuggestionsDialog(context, villages);
                  //       },
                  //       icon: const Icon(Icons.search),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => transiView(
                              sessionToken: sessionToken,
                              userName: userName,
                              userEmail: userMail,
                              userId: userId,
                              village_: _selectedVillage),
                        ),
                      );
                      // Perform action when "Next" button is pressed
                    },
                    child: const Text('NEXT'),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.red), // Set the border color
          ),
          title: const Text('Popup Message'),
          content: const Text(
              'As per Section 6(3)(ii) of the The Kerala Promotion of Tree Growth in Non-forest areas Act , 2005, such prior permission is not required  for the cutting and removal of trees mentioned in the schedule'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userMail,
                      userId: userId,
                    ),
                  ),
                );
                // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> getSuggestions(String query, List<VillageData> villageList) {
    if (query.isEmpty) {
      return []; // Return an empty list when query is empty
    }

    // Extract village names from the VillageData objects
    List<String> villageNames =
        villageList.map((village) => village.villageName).toList();

    // Filter the village names based on the query
    List<String> filteredVillages = villageNames
        .where(
            (village) => village.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return filteredVillages;
  }

  void _showSuggestionsDialog(
      BuildContext context, List<VillageData> villageList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('VILLAGE SUGGESTIONS'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  onTap: () {
                    final selectedVillageName = _suggestions[index];
                    final selectedVillage = villages.firstWhere(
                      (village) => village.villageName == selectedVillageName,
                      orElse: () => null,
                    );

                    if (selectedVillage != null) {
                      setState(() {
                        _searchController.text = selectedVillage.villageName;
                        _selectedVillage = selectedVillage.villageName;
                        _selectedVillageId = selectedVillage.id;
                        _isNotified = selectedVillage.isNotified;
                        _suggestions = []; // Clear suggestions
                        print("IDDDDD" + _selectedVillageId.toString());
                        print("isNot" + _isNotified.toString());
                        if (_isNotified == false) {
                          _showSpecias = false;
                        } else if (_isNotified == true) {
                          _showSpecias = true;
                        }
                      });
                    }

                    Navigator.pop(context); // Close the dialog
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://13.234.208.246/api/auth/villages/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data['status'] == 'success') {
        final villageList = data['villages'] as List<dynamic>;
        final parsedVillages =
            villageList.map((v) => VillageData.fromJson(v)).toList();

        setState(() {
          villages = parsedVillages;
        });
      }
    } else {
      // Handle error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
