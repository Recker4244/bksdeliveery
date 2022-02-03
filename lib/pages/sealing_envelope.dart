import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';

class SealingEnvelopeDetails extends StatefulWidget {
  const SealingEnvelopeDetails({Key key}) : super(key: key);

  @override
  _SealingEnvelopeDetailsState createState() => _SealingEnvelopeDetailsState();
}

class _SealingEnvelopeDetailsState extends State<SealingEnvelopeDetails> {
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
                  Text('Enter Sealing Envelope Details',
                      style:
                          primaryColor16MediumTextStyle.copyWith(fontSize: 18)),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Column(
                children: [
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
                        cursorColor: primaryColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          labelText: "Total Weight",
                          suffix:
                              Text("GRAM", style: primaryColor18BoldTextStyle),
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
                        cursorColor: primaryColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          labelText: "Serial Number",
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
                    height: 2.h,
                  ),
                  ElevatedButton(
                      child: Text(
                        "Selling Done",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 2.5.h)),
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
                        //         builder: (context) => EnterItemDetail()));
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
