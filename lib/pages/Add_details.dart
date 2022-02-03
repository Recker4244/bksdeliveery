import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/Detail.dart';
import 'package:gold247/models/style.dart';
import 'package:gold247/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/check_before_proceeding.dart';

List<style> styles = [];
int card = 1;
List<detail> details = [];

class AddDetails extends StatefulWidget {
  const AddDetails({Key key}) : super(key: key);

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  @override
  void initState() {
    super.initState();
    details = [];
    styles = [];
    card = 1;
    getstyle();
    setState(() {});
  }

  Future update() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/system-details/${Userdata.sId}'));
    final body = {
      "Details": [
        for (int i = 0; i < details.length; i++)
          {
            //"id": "61f63083d15f7d56116505e1",
            "styleID": details[i].styleID,
            "unitOfMeasurement": details[i].unitOfMeasurement,
            "units": details[i].units,
            "RateFixedPerUnit": details[i].rateFixedPerUnit,
            "Amount": details[i].amount
          }
      ]
    };
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Navigator.of(context).pop();
      Navigator.pop(context, det['data']['id']);
    } else {
      print(response.reasonPhrase);
      Navigator.of(context).pop();
    }
  }

  getstyle() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/system-styles/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      List<style> t = List<style>.from(l.map((model) => style.fromJson(model)));
      setState(() {
        styles = t;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> getColor(Color white, Color pressed) {
      final getColor = (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return pressed;
        } else
          return white;
      };
      return MaterialStateProperty.resolveWith(getColor);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldBgColor,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int cardno = 0; cardno < card; cardno++) AddDetailsCard(),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Text(
                          "Add New",
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 3.h)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            foregroundColor: getColor(whiteColor, primaryColor),
                            backgroundColor:
                                getColor(primaryColor, whiteColor)),
                        onPressed: () async {
                          setState(() {
                            card++;
                          });
                        }),
                    ElevatedButton(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 3.h)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            foregroundColor: getColor(whiteColor, primaryColor),
                            backgroundColor:
                                getColor(primaryColor, whiteColor)),
                        onPressed: () async {
                          await update();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             CheckBeforeProceeding()));
                        }),
                    ElevatedButton(
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 9.w, vertical: 3.h)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            foregroundColor: getColor(whiteColor, primaryColor),
                            backgroundColor:
                                getColor(primaryColor, whiteColor)),
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             CheckBeforeProceeding()));
                        }),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//card for appointment details
class AddDetailsCard extends StatefulWidget {
  const AddDetailsCard({
    Key key,
  }) : super(key: key);

  @override
  State<AddDetailsCard> createState() => _AddDetailsCardState();
}

class _AddDetailsCardState extends State<AddDetailsCard> {
  @override
  var styleSelectedValue1;
  var unitselectedValue;
  detail Detail = detail();
  TextEditingController amount = TextEditingController();
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: primaryColor),
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      elevation: 0,
                      isExpanded: true,
                      hint: Text(
                        'StyleID',
                        style: primaryColor16MediumTextStyle,
                      ),
                      value: styleSelectedValue1,
                      items: styles.map((style v) {
                        return DropdownMenuItem<String>(
                          value: v.sId,
                          child:
                              Text(v.name, style: primaryColor18BoldTextStyle),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        Detail.styleID = newValue;
                        setState(() {
                          styleSelectedValue1 = newValue;
                        });
                        print(styleSelectedValue1);
                      },
                    ),
                  ),
                ),
              ),
              // Theme(
              //   data: ThemeData(
              //     errorColor: primaryColor,
              //     primaryColor: whiteColor,
              //     textSelectionTheme: TextSelectionThemeData(
              //       cursorColor: primaryColor,
              //     ),
              //   ),
              //   child: TextFormField(
              //     cursorColor: primaryColor,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     keyboardType: TextInputType.number,
              //     style: primaryColor18BoldTextStyle,
              //     decoration: InputDecoration(
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(
              //           const Radius.circular(10.0),
              //         ),
              //         borderSide: BorderSide(color: primaryColor, width: 1),
              //       ),
              //       filled: true,
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(
              //           const Radius.circular(10.0),
              //         ),
              //         borderSide: BorderSide(color: primaryColor, width: 1),
              //       ),
              //       fillColor: whiteColor,
              //       labelText: "StyleId",
              //       // suffix: Text("GRAM",
              //       //     style: primaryColor18BoldTextStyle),
              //       labelStyle: primaryColor16MediumTextStyle,
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor, width: 0.7),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            Padding(
                padding: const EdgeInsets.all(fixPadding * 2),
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: primaryColor),
                    color: whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        elevation: 0,
                        hint: Text(
                          'Unit of Measurement',
                          style: primaryColor16MediumTextStyle,
                        ),
                        value: unitselectedValue,
                        items: <String>['Weight', 'Peices'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child:
                                Text(value, style: primaryColor18BoldTextStyle),
                          );
                        }).toList(),
                        onChanged: (String newvalue) {
                          Detail.unitOfMeasurement = newvalue;
                          setState(() {
                            unitselectedValue = newvalue;
                          });
                        },
                      ),
                    ),
                  ),
                )
                // Theme(
                //   data: ThemeData(
                //     errorColor: primaryColor,
                //     primaryColor: whiteColor,
                //     textSelectionTheme: TextSelectionThemeData(
                //       cursorColor: primaryColor,
                //     ),
                //   ),
                //   child: TextFormField(
                //     cursorColor: primaryColor,
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     keyboardType: TextInputType.number,
                //     style: primaryColor18BoldTextStyle,
                //     decoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: const BorderRadius.all(
                //           const Radius.circular(10.0),
                //         ),
                //         borderSide: BorderSide(color: primaryColor, width: 1),
                //       ),
                //       filled: true,
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: const BorderRadius.all(
                //           const Radius.circular(10.0),
                //         ),
                //         borderSide: BorderSide(color: primaryColor, width: 1),
                //       ),
                //       fillColor: whiteColor,
                //       labelText: "Unit of Measurement",
                //       // suffix: Text("GRAM",
                //       //     style: primaryColor18BoldTextStyle),
                //       labelStyle: primaryColor16MediumTextStyle,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: primaryColor, width: 0.7),
                //       ),
                //     ),
                //   ),
                // ),
                ),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Theme(
                data: ThemeData(
                  errorColor: primaryColor,
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    Detail.units = value;
                  },
                  cursorColor: primaryColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  style: primaryColor18BoldTextStyle,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    fillColor: whiteColor,
                    labelText: "Units",
                    labelStyle: primaryColor16MediumTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 0.7),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Theme(
                data: ThemeData(
                  errorColor: primaryColor,
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (card == details.length + 1) {
                      details.add(Detail);
                    }
                  },
                  onChanged: (value) {
                    Detail.rateFixedPerUnit = value;

                    setState(() {
                      amount.text = (num.parse(Detail.rateFixedPerUnit) *
                              num.parse(Detail.units))
                          .toStringAsFixed(2);
                    });
                    Detail.amount = amount.text;
                    if (card == details.length + 1) details.add(Detail);
                  },
                  cursorColor: primaryColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  style: primaryColor18BoldTextStyle,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    fillColor: whiteColor,
                    labelText: "Rate Fixed Per Unit",
                    suffix: Text("INR", style: primaryColor18BoldTextStyle),
                    labelStyle: primaryColor16MediumTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 0.7),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Theme(
                data: ThemeData(
                  errorColor: primaryColor,
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  enabled: false,
                  controller: amount,
                  cursorColor: primaryColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  style: primaryColor18BoldTextStyle,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    fillColor: whiteColor,
                    labelText: "Amount",
                    suffix: Text("INR", style: primaryColor18BoldTextStyle),
                    labelStyle: primaryColor16MediumTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 0.7),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
