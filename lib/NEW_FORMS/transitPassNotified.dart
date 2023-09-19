import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNonNot2.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNotified2.dart';
import 'package:tigramnks/homePage.dart';

class transitPassNotified extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village_;

  transitPassNotified(
      {this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId,
      this.formOneIndex,
      this.village_});

  @override
  State<transitPassNotified> createState() => _transitPassNotifiedState(
      formOneIndex, sessionToken, userName, userEmail, userId, village_);
}

class _transitPassNotifiedState extends State<transitPassNotified> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village__;

  _transitPassNotifiedState(this.formOneIndex, this.sessionToken, this.userName,
      this.userEmail, this.userId, this.village__);

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
  String no_Tree = "0";

  bool flag1 = true;
  int exindex = 1;
  Map<String, bool> SpeciasList = {
    'Rosewood(Dalbergia latifolia)': false,
    'Teak(Tectona grandis) ': false,
    'Thempavu(Terminalia tomantosa)': false,
    'Chadachi(Grewia tiliaefolia)': false,
    'Chandana vempu(Cedrela toona)': false,
    'Vellakil(Dysoxylum malabaricum)': false,
    'Irul(Xylia xylocarpa)': false,
    'Ebony(Diospyrus sp.)': false,
    'Kampakam(Hopea Parviflora)': false,
  };
  var holder_1 = [];
  bool _getHolderCheck() {
    // Define your logic here to determine the initial value of holder_check based on no_Tree.
    return int.parse(no_Tree) > 0;
  }

  bool holder_check;
  double v;
  double _getVolume(double girth, double length) {
    v = ((girth * 0.01) / 4) * ((girth * 0.01) / 4) * length;
    return v;
  }

  Widget getTextV(BuildContext context, double girth, double length) {
    return Text((_getVolume(girth, length).toString()).toString());
  }

  List log_details = [];
  List d = [];
  List Species = [];
  List Length = [];
  List Girth = [];
  List Volume = [];
  List Latitude = [];
  List Longitude = [];
  List n_list = [];
  bool flag_no = false;

  int _radioValue = 0;
  int _radioValue2 = 0;
  String maintenance;
  bool flag_land = false;
  bool flag_sp = false;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag_land = true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag_land = false;
        });
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;
      if (_radioValue2 == 1) {
        maintenance = 'YES';
        setState(() {
          flag_sp = true;
        });
      } else if (_radioValue2 == 2) {
        maintenance = 'NO';
        setState(() {
          flag_sp = false;
        });
      }
    });
  }

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

  getItems() {
    SpeciasList.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });
    print(holder_1);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      LoadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
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
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15.0,
                  right: 15.0,
                ),
                child: Text(
                  'Is extent of land below 1 Ha?  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 15),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              'Yes',
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              'No',
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                        ),
                      ]),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (flag_land == true) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    child: Scrollbar(
                                      isAlwaysShown:
                                          true, // Show the scrollbar always
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: speciasTextList
                                              .map((text) =>
                                                  ListTile(title: Text(text)))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (flag_land == false) {
                            return Container(
                              color: Colors.white,
                            );
                          }
                        },
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (flag_land == true) {
                            return Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Text(
                                  'Are you applying for any of the specified trees given above?  ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      'Yes',
                                      style: TextStyle(fontFamily: 'Lato'),
                                    ),
                                    value: 1,
                                    groupValue: _radioValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        _handleRadioValueChange2(value);
                                        _showPopupMessage(context);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      'No',
                                      style: TextStyle(fontFamily: 'Lato'),
                                    ),
                                    value: 2,
                                    groupValue: _radioValue2,
                                    onChanged: _handleRadioValueChange2,
                                  ),
                                ),
                              ])
                            ]);
                          } else if (flag_sp == false) {
                            return Container(
                              color: Colors.white,
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 20, bottom: 0),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                                text:
                                    "Division                                Range",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(top: 8, left: 15, right: 15),
                        decoration: new BoxDecoration(
                            border: new Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10, bottom: 0),
                        child: Row(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: divisionData,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              hint: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Select Division",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              onChanged: (String data) {
                                setState(() {
                                  divisionData = data;
                                });
                                print(divisionData);
                              },
                              items: divisions
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                            Spacer(),
                            DropdownButton<String>(
                              value: rangeData,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              hint: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Select Range",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              onChanged: (String data) {
                                setState(() {
                                  rangeData = data;
                                });
                                print(rangeData);
                              },
                              items: ranges
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: Name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Name *',
                                hintText: 'Enter Your Name'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Address,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              labelText: 'Address*',
                              hintText: 'Enter Your Address'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: survey_no,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              labelText: 'Survey Number*',
                              hintText: 'Enter Survey Number'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Tree_Proposed_to_cut,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              labelText: 'Trees Proposed to be cut*',
                              hintText: 'Enter Number of Trees'),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                          onChanged: ((value) {
                            no_Tree = value;
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: DistrictCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'District *',
                                hintText: 'Enter Your District'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: TalukCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Taluk *',
                                hintText: 'Enter Your Taluk'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: blockCo,
                            enabled: true, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                labelText: 'Block (optional)',
                                hintText: 'Enter Your Block'),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: villageCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Village *',
                                hintText: 'Enter Your Village'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: pincodeCo,
                            enabled: true, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Pincode *',
                                hintText: 'Enter Your Pincode'),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Row(children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 13, top: 15),
                          child: Text(
                            'Species of tree or trees proposed to be cut:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                            // Your decoration properties
                            ),
                        child: Scrollbar(
                          // Wrap your ListView with Scrollbar
                          isAlwaysShown: true, // Show the scrollbar always
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: SpeciasList.keys.map((String key) {
                              return new CheckboxListTile(
                                title: new Text(key),
                                value: SpeciasList[key],
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                onChanged: (bool value) {
                                  holder_check = _getHolderCheck();
                                  if (int.parse(no_Tree) > 0) {
                                    if (value == true) {
                                      if (holder_check &&
                                          holder_1.length <
                                              int.parse(no_Tree)) {
                                        holder_1.add(key);
                                        if (holder_1.length >=
                                            int.parse(no_Tree)) {
                                          holder_check =
                                              false; // Disable further selection
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You can only add $no_Tree species",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 18.0);
                                        }
                                      }
                                    } else if (value == false) {
                                      holder_1.remove(key);
                                      if (!holder_check) {
                                        holder_check =
                                            true; // Re-enable selection when items are removed
                                      }
                                    }
                                    setState(() {
                                      SpeciasList[key] = value;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Purpose,
                          //  obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(14.0)),
                              ),
                              labelText: 'Purpose',
                              hintText:
                                  ' Enter Purpose for which trees or trees proposed to be cut'),
                        ),
                      ),
                      Container(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              LayoutBuilder(builder: (context, constraints) {
                                if (flag1 == true) {
                                  return Column(
                                    children: [
                                      Column(children: [
                                        LayoutBuilder(
                                            builder: (context, constraints) {
                                          print(n_list.length);
                                          int textValue = 0;
                                          if (Tree_Proposed_to_cut.text ==
                                                  null ||
                                              Tree_Proposed_to_cut.text == "") {
                                            textValue = 0;
                                          } else {
                                            textValue = int.parse(
                                                Tree_Proposed_to_cut.text);
                                          }

                                          if (textValue > n_list.length) {
                                            flag_no = true;
                                            return Text(
                                              "Add log details for all trees",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            );
                                          } else {
                                            flag_no = false;
                                            return Text(
                                              "",
                                              style: TextStyle(fontSize: 1),
                                            );
                                          }
                                        })
                                      ]),
                                      Container(
                                          margin: const EdgeInsets.all(10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.29,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(2.0,
                                                    2.0), // shadow direction: bottom right
                                              )
                                            ],
                                          ),
                                          child: Scrollbar(
                                              isAlwaysShown: true,
                                              thickness: 15,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Column(
                                                      children: <Widget>[
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                              'Sr.No',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                            DataColumn(
                                                                label: Text(
                                                              'Species  ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                            DataColumn(
                                                                label: Text(
                                                              '  GBH(cm)  ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                            DataColumn(
                                                                label: Text(
                                                              ' Height(M)   ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                            DataColumn(
                                                              label: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "Add log",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        flag_no ==
                                                                            true,
                                                                    child:
                                                                        IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .add_circle,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await showInformationDialog(
                                                                            context);
                                                                        print(
                                                                            "-------------Total-log------------");
                                                                        print(
                                                                            log_details);
                                                                        setState(
                                                                            () {
                                                                          DataRow;
                                                                          exindex =
                                                                              exindex + 1;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                          rows: n_list
                                                              .map(((index) =>
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Text((index +
                                                                                1)
                                                                            .toString())),
                                                                        DataCell(Container(
                                                                            width: 180,
                                                                            child: Text(
                                                                              log_details[index]['species_of_tree'].toString(),
                                                                            ))),
                                                                        DataCell(Container(
                                                                            width: 100,
                                                                            child: Text(
                                                                              log_details[index]['breadth'].toString(),
                                                                            ))),
                                                                        DataCell(Container(
                                                                            width: 100,
                                                                            child: Text(
                                                                              log_details[index]['length'].toString(),
                                                                            ))),
                                                                        DataCell(
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Text("remove"),
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.remove_circle,
                                                                                color: Colors.red,
                                                                              ),
                                                                              onPressed: () {
                                                                                flag_no = true;

                                                                                print(index);
                                                                                print(log_details);
                                                                                log_details.removeAt(index);
                                                                                n_list.removeLast();
                                                                                print(log_details);
                                                                                setState(() {
                                                                                  DataRow;
                                                                                });
                                                                              },
                                                                            ), //--------------Remove Button
                                                                            Text("edit"),
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.edit_rounded,
                                                                                color: Colors.blue,
                                                                              ),
                                                                              onPressed: () async {
                                                                                print("-------------Edit--Total-log------------");
                                                                                print(index);

                                                                                print(log_details);
                                                                                await EditInformationDialog(context, index);
                                                                                setState(() {
                                                                                  DataRow;
                                                                                });
                                                                              },
                                                                            )
                                                                          ],
                                                                        )),
                                                                      ])))
                                                              .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  )))),
                                    ],
                                  );
                                } else if (flag1 == false) {
                                  return Container(
                                    color: Colors.white,
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            backgroundColor: HexColor("#0499f2"),
            onPressed: () {
              print("Button Pressed"); // Add this line for debugging
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => transitPassNotified2(
                      formOneIndex: formOneIndex,
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userEmail,
                      userId: userId,
                      Name_: Name.text,
                      Division_: divisionData,
                      range_: rangeData,
                      address_: Address.text,
                      survey_no_: survey_no.text,
                      tree_no_cut: no_Tree,
                      district_: DistrictCo.text,
                      taluke_: TalukCo.text,
                      block_: blockCo.text,
                      village_: villageCo.text,
                      pincode_: pincodeCo.text,
                      holder_1: holder_1,
                      purpose_: Purpose.text,
                      log_details: log_details),
                ),
              );
              setState(() {});
            }),
      ),
    );
  }

  String dropdownValue3;
  String spacies_holder = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: length,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Height(M)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'OK ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.length == 0) ||
                        (girth.text.length == 0)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                      };
                      log_details.add(logs);
                      int n = log_details.length;
                      n_list = [];
                      //
                      //  List n_list =[];
                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }
                      print("----n_list--");
                      print("$n_list" + "NLIST");
                      print(Species);
                      print(d);
                      length.clear();
                      girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> EditInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          dropdownValue3 = log_details[index]['species_of_tree'];
          length.text = log_details[index]['length'];
          girth.text = log_details[index]['breadth'];
          volume.text = log_details[index]['volume'];

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller: length,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter height(M)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text(
                    'OK ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.length == 0) ||
                        (girth.text.length == 0)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                      };

                      log_details[index] = logs;
                      int n = log_details.length;
                      n_list = [];

                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }
                      print("----n_list--");
                      print(n_list);
                      print(Species);
                      print(d);
                      if (_formKey.currentState.validate()) {
                        length.clear();
                        girth.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: const Text('Do you want to go previous page'),
            content: const Text('Changes you made may not be saved.'),
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

  String villageTaluka = "";
  String villageDist = "";
  String divisionData;
  String rangeData;
  List<String> ranges = [];
  List<String> divisions = [];
  LoadData() async {
    int DL = 0;
    const String url = 'http://13.234.208.246/api/auth/villages/';
    Map data = {
      "village": village__,
    };
    print("REQUST   $data");
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    villageTaluka = responseJson['data']['village_taluka'];
    villageDist = responseJson['data']['village_dist'];

    List<dynamic> possibilityList = responseJson['data']['possibility'];
    for (var possibility in possibilityList) {
      String range = possibility['range'];
      String divi = possibility['division'];
      divisions.add(divi);
      ranges.add(range);
    }

    print('Village Taluka: $villageTaluka');
    print('Village District: $villageDist');
    print('Ranges: $ranges');

    setState(() {
      TalukCo.text = villageTaluka;
      DistrictCo.text = villageDist;
      villageCo.text = village__;
    });
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
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userEmail,
                      userId: userId,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
