import 'package:flutter/material.dart';
import 'package:gold247/models/collectionList.dart';
import 'package:gold247/models/processDetail.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Add_details.dart';
import 'package:gold247/pages/check_before_proceeding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List<processdetail> process = [];
int card = 1;
// final _formkey = GlobalKey<FormState>();

class PurchaseEntry extends StatefulWidget {
  final collectionList appointment;
  const PurchaseEntry({Key key, this.appointment}) : super(key: key);

  @override
  _PurchaseEntryState createState() => _PurchaseEntryState();
}

class _PurchaseEntryState extends State<PurchaseEntry> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    process = [];
    card = 1;
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

    Future proceed() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
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
              'https://goldv2.herokuapp.com/api/appointment-process/create/${Userdata.sId}'));
      final body = {
        "Details": [
          for (int i = 0; i < process.length; i++)
            {
              "DetailID": "61f859f29871b9001636fdb7",
              "GrossWeight": process[i].grossWeight,
              "NetWeight": process[i].netWeight,
              "ItemPhoto":
                  "Fbksarafjewellers_260605054_4525615310885611_739919899372511286_n.jpeg",
              "PurityPhoto":
                  "Fbksarafjewellers_260605054_4525615310885611_739919899372511286_n.jpeg"
            }
        ]
      };
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Entry"),
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
                for (int cardno = 0; cardno < card; cardno++)
                  PurchaseEntryCard(),
                ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: fixPadding * 2.5,
                          horizontal: fixPadding * 8.5),
                      child: Text(
                        "Add One More Item",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        // padding: MaterialStateProperty.all(
                        //     EdgeInsets.symmetric(
                        //         horizontal: 16.w, vertical: 2.5.h)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        foregroundColor: getColor(whiteColor, primaryColor),
                        backgroundColor: getColor(primaryColor, whiteColor)),
                    onPressed: () async {
                      setState(() {
                        card++;
                      });
                    }),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: fixPadding * 2.5,
                          horizontal: fixPadding * 12.5),
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        // padding: MaterialStateProperty.all(
                        //     EdgeInsets.symmetric(
                        //         horizontal: 16.w, vertical: 2.5.h)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        foregroundColor: getColor(whiteColor, primaryColor),
                        backgroundColor: getColor(primaryColor, whiteColor)),
                    onPressed: () async {
                      if (true) {
                        num gross = 0;
                        for (int i = 0; i < process.length; i++)
                          gross += num.parse(process[i].grossWeight);
                        num net = 0;
                        for (int i = 0; i < process.length; i++)
                          net += num.parse(process[i].netWeight);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckBeforeProceeding(
                                      appointmentId: widget.appointment.id,
                                      gross: gross.toStringAsFixed(2),
                                      net: net.toStringAsFixed(2),
                                    )));
                      }
                    }),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PurchaseEntryCard extends StatefulWidget {
  const PurchaseEntryCard({
    Key key,
  }) : super(key: key);

  @override
  State<PurchaseEntryCard> createState() => _PurchaseEntryCardState();
}

class _PurchaseEntryCardState extends State<PurchaseEntryCard> {
  processdetail processDetail = processdetail();

  TextEditingController gross = TextEditingController();

  TextEditingController net = TextEditingController();

  TextEditingController purity = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController amount = TextEditingController();

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

    return Form(
      child: Column(
        children: [
          Divider(thickness: 0.5, color: primaryColor),
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Padding(
                  padding: const EdgeInsets.all(fixPadding),
                  child: Theme(
                    data: ThemeData(
                      errorColor: primaryColor,
                      primaryColor: whiteColor,
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: primaryColor,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //keyboardType: TextInputType.number,
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
                        labelText: "Item Name",
                        labelStyle: primaryColor16MediumTextStyle,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  child: Text(
                    "Add Details",
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 2.5.h)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      foregroundColor: getColor(whiteColor, primaryColor),
                      backgroundColor: getColor(primaryColor, whiteColor)),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDetails()));
                  }),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Weight Details", style: primaryColor18BoldTextStyle)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Theme(
                  data: ThemeData(
                    errorColor: primaryColor,
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "This field is required";
                      return null;
                    },
                    onChanged: (value) {
                      processDetail.grossWeight = gross.text;
                    },
                    controller: gross,
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
                      labelText: "Gross Weight",
                      suffix: Text("GRAM", style: primaryColor18BoldTextStyle),
                      labelStyle: primaryColor16MediumTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Theme(
                  data: ThemeData(
                    errorColor: primaryColor,
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "This field is required";
                      return null;
                    },
                    controller: net,
                    onChanged: (value) {
                      processDetail.netWeight = net.text;
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
                      labelText: "Net Weight",
                      suffix: Text("GRAM", style: primaryColor18BoldTextStyle),
                      labelStyle: primaryColor16MediumTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(fixPadding ),
              //   child: Theme(
              //     data: ThemeData(
              //       errorColor: primaryColor,
              //       primaryColor: whiteColor,
              //       textSelectionTheme: TextSelectionThemeData(
              //         cursorColor: primaryColor,
              //       ),
              //     ),
              //     child: TextFormField(
              //       cursorColor: primaryColor,
              //       autovalidateMode: AutovalidateMode.onUserInteraction,
              //       keyboardType: TextInputType.number,
              //       style: primaryColor18BoldTextStyle,
              //       decoration: InputDecoration(
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: const BorderRadius.all(
              //             const Radius.circular(10.0),
              //           ),
              //           borderSide:
              //               BorderSide(color: primaryColor, width: 1),
              //         ),
              //         filled: true,
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: const BorderRadius.all(
              //             const Radius.circular(10.0),
              //           ),
              //           borderSide:
              //               BorderSide(color: primaryColor, width: 1),
              //         ),
              //         fillColor: whiteColor,
              //         labelText: "Stone Weight",
              //         suffix:
              //             Text("GRAM", style: primaryColor18BoldTextStyle),
              //         labelStyle: primaryColor16MediumTextStyle,
              //         border: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: primaryColor, width: 0.7),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Theme(
                  data: ThemeData(
                    errorColor: primaryColor,
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "This field is required";
                      return null;
                    },
                    onChanged: (value) {
                      // processDetail. = net.text;
                    },
                    controller: purity,
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
                      labelText: "Purity",
                      labelStyle: primaryColor16MediumTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding),
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
                      num totalprice = num.parse(net.text) *
                          num.parse(purity.text) *
                          0.01 *
                          num.parse(price.text);

                      amount.text = totalprice.toStringAsFixed(2);
                      if (card == process.length + 1) {
                        process.add(processDetail);
                      }
                    },
                    onFieldSubmitted: (value) {},
                    controller: price,
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
                      labelText: "Metal Price",
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
                padding: const EdgeInsets.all(fixPadding),
                child: Theme(
                  data: ThemeData(
                    errorColor: primaryColor,
                    primaryColor: whiteColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: TextFormField(
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
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10.0)),
                        borderSide: BorderSide(color: primaryColor, width: 1),
                      ),
                      fillColor: whiteColor,
                      labelText: "Total",
                      suffix: Text("INR", style: primaryColor18BoldTextStyle),
                      labelStyle: primaryColor16MediumTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(fixPadding * 2),
              //   child: Row(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border:
              //                 Border.all(width: 1.0, color: primaryColor),
              //             color: whiteColor),
              //         width: 80.w,
              //         height: 7.h,
              //         child: Row(
              //           children: [
              //             Padding(
              //               padding:
              //                   const EdgeInsets.only(left: 10, right: 63),
              //               child: Center(
              //                   child: Text(
              //                 "Purity Photo",
              //                 style: primaryColor16MediumTextStyle,
              //               )),
              //             ),
              //             Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   border: Border.all(
              //                       width: 2.0, color: Colors.grey),
              //                   color: scaffoldLightColor),
              //               width: 40.w,
              //               child: Center(
              //                   child: Text(
              //                 "Choose File",
              //                 style: primaryColor16MediumTextStyle.copyWith(
              //                     color: Colors.grey, fontSize: 18),
              //               )),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text(
                        "Add Item Photo",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          foregroundColor: getColor(whiteColor, primaryColor),
                          backgroundColor: getColor(primaryColor, whiteColor)),
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CheckBeforeProceeding()));
                      }),
                  ElevatedButton(
                      child: Text(
                        "Add Purity Photo",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          foregroundColor: getColor(whiteColor, primaryColor),
                          backgroundColor: getColor(primaryColor, whiteColor)),
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CheckBeforeProceeding()));
                      }),
                ],
              ),

              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
