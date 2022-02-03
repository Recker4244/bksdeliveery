import 'package:flutter/material.dart';
import 'package:gold247/models/finalDetails.dart';
import 'package:gold247/pages/portfolio/Collections.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/lastStep.dart';
import 'package:gold247/pages/sealing_envelope.dart';
import 'Purcahse_entry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckBeforeProceeding extends StatefulWidget {
  final String appointmentId;
  final String gross;
  final String net;
  final String purity;

  const CheckBeforeProceeding(
      {Key key, this.appointmentId, this.gross, this.net, this.purity})
      : super(key: key);

  @override
  _CheckBeforeProceedingState createState() => _CheckBeforeProceedingState();
}

class _CheckBeforeProceedingState extends State<CheckBeforeProceeding> {
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
      backgroundColor: scaffoldLightColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
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
                  Text('Check Befor Proceeding',
                      style:
                          primaryColor16MediumTextStyle.copyWith(fontSize: 18)),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
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
                          child: Text('${finalappt.appoitmnetProcessDetailsID}',
                              style: primaryColor16MediumTextStyle.copyWith(
                                  color: Colors.black)),
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
                      Text('Total Gross Weight:',
                          style: primaryColor16MediumTextStyle.copyWith(
                              color: Colors.black)),
                      Text('${widget.gross} GRAM',
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
                      Text('Total Net Weight:',
                          style: primaryColor16MediumTextStyle.copyWith(
                              color: Colors.black)),
                      Text('${widget.net} GRAM',
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
                      Text('Approx Purity:',
                          style: primaryColor16MediumTextStyle.copyWith(
                              color: Colors.black)),
                      Text('${widget.purity}',
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
                      Text('Approx Valuation:',
                          style: primaryColor16MediumTextStyle.copyWith(
                              color: Colors.black)),
                      Text(
                          '${num.parse(widget.net) * num.parse(widget.purity) * 0.01 * metalprice + totaldetailamount} INR',
                          style: primaryColor16MediumTextStyle),
                    ],
                  ),
                ],
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
              //         child: Center(
              //             child: Text(
              //           "INR 54,000",
              //           style: primaryColor22BoldTextStyle,
              //         )),
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Fifty Four Thousand Rupees Only',
              //         style: primaryColor16MediumTextStyle),
              //   ],
              // ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text(
                        "Opt In",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 2.5.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          foregroundColor: getColor(whiteColor, primaryColor),
                          backgroundColor: getColor(primaryColor, whiteColor)),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OneLastStep()));
                      }),
                  ElevatedButton(
                      child: Text(
                        "Opt Out",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 2.5.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          foregroundColor: getColor(whiteColor, primaryColor),
                          backgroundColor: getColor(primaryColor, whiteColor)),
                      onPressed: () async {
                        var headers = {'Content-Type': 'application/json'};
                        var request = http.Request(
                            'PUT',
                            Uri.parse(
                                'http://13.59.57.74:5000/api/appointment/status/${finalappt.appointmentID}'));
                        request.body = json.encode({
                          "status": "Cancelled",
                        });
                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Collections()));
                        } else {
                          print(response.reasonPhrase);
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
