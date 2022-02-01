import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/complete_last_step.dart';
import 'package:gold247/pages/sealing_envelope.dart';

class OneLastStep extends StatefulWidget {
  const OneLastStep({Key key}) : super(key: key);

  @override
  _OneLastStepState createState() => _OneLastStepState();
}

class _OneLastStepState extends State<OneLastStep> {
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
                      Text('Final Process',
                          style: primaryColor16MediumTextStyle.copyWith(
                              fontSize: 18)),
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
                          Text('Enter Details',
                              style: primaryColor16MediumTextStyle.copyWith(
                                  fontSize: 18))
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: fixPadding),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              fillColor: whiteColor,
                              labelText: "Melted Weight",
                              suffix: Text("GRAM",
                                  style: primaryColor18BoldTextStyle),
                              labelStyle: primaryColor16MediumTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: fixPadding),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              fillColor: whiteColor,
                              labelText: "Average Purity",
                              suffix: Text("Fitness",
                                  style: primaryColor18BoldTextStyle),
                              labelStyle: primaryColor16MediumTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
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
                                  child: Text('#fhdsoifjdsfisop942vcbfd',
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
                              Text('Total Gross Weight:',
                                  style: primaryColor16MediumTextStyle.copyWith(
                                      color: Colors.black)),
                              Text('10 GRAM',
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
                              Text('8.6 GRAM',
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
                              Text('24',
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
                              Text('INR 3,73,000',
                                  style: primaryColor16MediumTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              horizontal: 15.w,
                                              vertical: 2.5.h)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      foregroundColor:
                                          getColor(whiteColor, primaryColor),
                                      backgroundColor:
                                          getColor(primaryColor, whiteColor)),
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompleteLastStep()));
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
                                              horizontal: 14.w,
                                              vertical: 2.5.h)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      foregroundColor:
                                          getColor(whiteColor, primaryColor),
                                      backgroundColor:
                                          getColor(primaryColor, whiteColor)),
                                  onPressed: () async {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             OneLastStep()));
                                  }),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ]))));
  }
}
