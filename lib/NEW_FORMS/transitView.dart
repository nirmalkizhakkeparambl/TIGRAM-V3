import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class transiView extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village_;

  transiView(
      {this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId,
      this.formOneIndex,
      this.village_});

  @override
  State<transiView> createState() => _transiViewState(
      formOneIndex, sessionToken, userName, userEmail, userId, village_);
}

class _transiViewState extends State<transiView> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village__;
  TextEditingController Division = TextEditingController();
  TextEditingController Range = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController DistrictCo = TextEditingController();
  TextEditingController TalukCo = TextEditingController();
  TextEditingController blockCo = TextEditingController();
  TextEditingController pincodeCo = TextEditingController();
  TextEditingController villageCo = TextEditingController();
  TextEditingController Purpose = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController girth = TextEditingController();
  TextEditingController volume = TextEditingController();

  _transiViewState(this.formOneIndex, this.sessionToken, this.userName,
      this.userEmail, this.userId, this.village__);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() {}),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NewGradientAppBar(
          title: const Text(
            "Form II - Notified",
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
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 1),
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
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        trailing: Text("Name.toString()",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      elevation: 2,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          'Address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      elevation: 2,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Name.toString()",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      elevation: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: const Text('Do you want to go previous page'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: const Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
