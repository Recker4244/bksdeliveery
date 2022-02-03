import 'package:flutter/material.dart';
import 'package:gold247/models/finalDetails.dart';
import 'package:gold247/pages/portfolio/Collections.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/sealing_envelope.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CompleteLastStep extends StatefulWidget {
  final String valuation;
  const CompleteLastStep({Key key, this.valuation}) : super(key: key);

  @override
  _CompleteLastStepState createState() => _CompleteLastStepState();
}

class _CompleteLastStepState extends State<CompleteLastStep> {
  lastStep() async {
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
            'https://goldv2.herokuapp.com/api/final-appointment/create/'));
    final body = {
      "AppoitmnetProcessDetailsID": finalappt.appoitmnetProcessDetailsID,
      "AppointmentID": finalappt.appointmentID,
      "MeltedWeight": finalappt.meltedWeight,
      "FinalPurity": finalappt.finalPurity,
      "PurityPhoto": finalappt.purityPhoto,
      "Status": "Accepted",
      "SerialNumber": finalappt.serialNumber,
      "TotalWeightIncludingEnvelope": finalappt.totalWeightIncludingEnvelope
    };
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Collections()));
    } else {
      print(response.reasonPhrase);
      Navigator.of(context).pop();
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
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldBgColor,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF95203D),
                          size: 30.0,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text('Complete the Last Step',
                          style: primaryColor16MediumTextStyle.copyWith(
                              fontSize: 18)),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Appointment Details ID:',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                              SizedBox(
                                width: 50.w,
                                height: 3.h,
                                // child: Wrap(
                                //   alignment: WrapAlignment.end,
                                //   children: [
                                //     Text('#BKS1234564iohfioefuwe89234532',
                                //         style: primaryColor16MediumTextStyle.copyWith(
                                //             color: Colors.black)),
                                //   ],
                                // ),
                                child: FittedBox(
                                  child: Text(
                                      '${finalappt.appoitmnetProcessDetailsID}',
                                      style: primaryColor16MediumTextStyle
                                          .copyWith(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Final Weight After Melting:',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                              Text(
                                  '${finalappt.meltedWeight.toStringAsFixed(2)} GRAM',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Final Purity:',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                              Text(
                                  '${finalappt.finalPurity.toStringAsFixed(2)}',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Final Valuation:',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                              Text('INR ${widget.valuation}',
                                  style: primaryColor16MediumTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Enter Details',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      fontSize: 18))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: fixPadding),
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
                                  finalappt.serialNumber = value;
                                },
                                cursorColor: primaryColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                //keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  fillColor: whiteColor,
                                  labelText: "Serial Number",
                                  // suffix: Text("GRAM",
                                  //     style: primaryColor18BoldTextStyle),
                                  labelStyle: primaryColor16MediumTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: fixPadding),
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
                                  finalappt.totalWeightIncludingEnvelope =
                                      num.parse(value);
                                },
                                cursorColor: primaryColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  fillColor: whiteColor,
                                  labelText: "Total Weight Including Envelope",
                                  // suffix: Text("Fitness",
                                  //     style: primaryColor18BoldTextStyle),
                                  labelStyle: primaryColor16MediumTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    child: Text(
                                      "Click to Proceed",
                                      style: TextStyle(
                                        fontFamily: 'Jost',
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                                  foregroundColor:
                                      getColor(whiteColor, primaryColor),
                                  backgroundColor:
                                      getColor(primaryColor, whiteColor)),
                              onPressed: () async {
                                await lastStep();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => CheckBeforeProceeding()));
                              }),
                        ],
                      )
                    ],
                  ),
                ]))));
  }
}
