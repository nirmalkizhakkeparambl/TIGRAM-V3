import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/userScann.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ViewApplication.dart';

class acknowUser extends StatefulWidget {
  int userId;
  String userName;
  String userEmail;
  String sessionToken;
  String userGroup;
  acknowUser({
    this.userId,
    this.userName,
    this.userEmail,
    this.sessionToken,
    this.userGroup,
  });
  @override
  State<acknowUser> createState() => _acknowUserState(
        userId,
        userName,
        userEmail,
        sessionToken,
        userGroup,
      );
}

class _acknowUserState extends State<acknowUser> {
  void initState() {
    super.initState();
    ScanApp();
  }

  int userId;
  String userName;
  String userEmail;
  String sessionToken;
  String userGroup;
  _acknowUserState(
    this.userId,
    this.userName,
    this.userEmail,
    this.sessionToken,
    this.userGroup,
  );
  final List sr = [];
  final List Ids = [];
  final List Check_officer_id = [];
  final List App_no = [];

  List list1 = [];
  int allApplication = 0;

  void ScanApp() async {
    sr.clear();
    Check_officer_id.clear();
    App_no.clear();
    const String url = 'http://13.234.208.246api/auth/ScanedListApplication';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List list = responseJSON["data"];
    setState(() {
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add(i.toString());
      App_no.add(list[i]['app_form_id'].toString());
      Check_officer_id.add(list[i]["checkpost_officer_id"].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: Text("Acknowledge Dashboard"),
        gradient:
            LinearGradient(colors: [HexColor("#26f596"), HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => userScan(
                              userId: userId,
                              sessionToken: sessionToken,
                              userName: userName,
                              userEmail: userEmail,
                              userGroup: userGroup,
                            )));
              },
              child: const Text("Acknowledge by Scan QR code"),
            )),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrangeAccent,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 10),
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
              child: Scrollbar(
                  isAlwaysShown: true,
                  thickness: 15,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Scrollbar(
                          isAlwaysShown: true,
                          thickness: 15,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columnSpacing: 20,
                                dividerThickness: 2,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.orange),
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'Sr.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                      label: Text(
                                    'Application\n       No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' View \n details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Download\n Report',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'QR Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows:
                                    sr // Loops through dataColumnText, each iteration assigning the value to element
                                        .map(
                                          ((value) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell((Text((int.parse(
                                                              value) +
                                                          1)
                                                      .toString()))), //Extracting from Map element the value
                                                  DataCell(Text(
                                                      App_no[int.parse(value)]
                                                          .toString())),

                                                  DataCell(
                                                    new Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: new Icon(
                                                            Icons.visibility),
                                                        color: Colors.blue,
                                                        onPressed: () {
                                                          if (userGroup ==
                                                              userGroup) {
                                                            String IDS = App_no[
                                                                    int.parse(
                                                                        value)]
                                                                .toString();
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        ViewApplication(
                                                                          sessionToken:
                                                                              sessionToken,
                                                                          userGroup:
                                                                              userGroup,
                                                                          userId:
                                                                              userId,
                                                                          Ids:
                                                                              IDS,
                                                                        )));
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    new Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: new Icon(Icons
                                                            .file_download),
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          await launch(
                                                              "http://13.234.208.246api/auth/new_transit_pass_pdf/" +
                                                                  App_no[int.parse(
                                                                      value)] +
                                                                  "/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  // DataCell(
                                                  //   IconButton(
                                                  //     icon: new Icon(
                                                  //         Icons.file_download),
                                                  //     color: Colors.blue,
                                                  //     onPressed: () async {
                                                  //       await launch(
                                                  //           "http://13.234.208.246api/auth/new_user_report/" +
                                                  //               Ids[int.parse(
                                                  //                   value)] +
                                                  //               "/");
                                                  //       // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                  //     },
                                                  //   ),
                                                  // ),

                                                  DataCell(
                                                    new Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: new Icon(Icons
                                                            .qr_code_outlined),
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          await launch(
                                                              "http://13.234.208.246api/auth/qr_code_pdf/" +
                                                                  App_no[int.parse(
                                                                      value)] +
                                                                  "/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                        .toList(),
                              ))))));
        }),
      ])),
    );
  }
}
