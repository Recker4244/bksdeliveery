import 'package:flutter/material.dart';
import 'package:gold247/models/collectionList.dart';
import 'package:gold247/models/finalDetails.dart';
import 'package:gold247/models/processDetail.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Add_details.dart';
import 'package:gold247/pages/check_before_proceeding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  Future proceed() async {
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
            'https://goldv2.herokuapp.com/api/appointment-process/create/${Userdata.sId}'));
    final body = {
      "Details": [
        for (int i = 0; i < process.length; i++)
          {
            "ItemName": process[i].itemName,
            "DetailID": process[i].detailID,
            "GrossWeight": widget.appointment.weight,
            "NetWeight": process[i].netWeight,
            "Purity": process[i].purity,
            "ItemPhoto": process[i].itemPhoto,
            "Total": process[i].total
          }
      ]
    };
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();

      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      if (true) {
        num gross = 0;
        for (int i = 0; i < process.length; i++)
          gross += process[i].grossWeight;
        num net = 0;
        for (int i = 0; i < process.length; i++) net += process[i].netWeight;
        finalappt.appoitmnetProcessDetailsID = det['data']['id'];
        finalappt.appointmentID = widget.appointment.id;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckBeforeProceeding(
                      appointmentId: det['data']['id'],
                      gross: gross.toStringAsFixed(2),
                      net: net.toStringAsFixed(2),
                    )));
      }
    } else {
      print(response.reasonPhrase);
      Navigator.of(context).pop();
    }
  }

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
                  PurchaseEntryCard(
                    gross: widget.appointment.weight,
                  ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckBeforeProceeding()));
                      // await proceed();
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
  final num gross;
  const PurchaseEntryCard({
    this.gross,
    Key key,
  }) : super(key: key);

  @override
  State<PurchaseEntryCard> createState() => _PurchaseEntryCardState();
}

class _PurchaseEntryCardState extends State<PurchaseEntryCard> {
  processdetail processDetail = processdetail();

  TextEditingController gross = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController net = TextEditingController();

  TextEditingController purity = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController amount = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      gross.text = widget.gross.toStringAsFixed(2);
    });
  }

//calculate netweight
  Future getdetailsbyid(String id) async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/system-details/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      num netweight = 0;
      for (int i = 0; i < det['data']['Details'].length; i++) {
        netweight += num.parse(det['data']['Details'][i]['units']);
      }
      num amount = 0;
      for (int i = 0; i < det['data']['Details'].length; i++) {
        amount += num.parse(det['data']['Details'][i]['Amount']);
      }
      setState(() {
        net.text = (num.parse(gross.text) - netweight).toStringAsFixed(2);
      });
      processDetail.netWeight = (num.parse(gross.text) - netweight);
      processDetail.total = amount;
      return amount;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future upload_picture(String path) async {
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
                      'Uploading..',
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

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/final-appointment/uploadPurityPhoto'));
    request.files.add(await http.MultipartFile.fromPath('PurityPhoto', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      processDetail.itemPhoto = det['PurityPhoto'];
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      print(response.reasonPhrase);
    }
  }

  File file;
  Future selectprofilepic(ImageSource source) async {
    final _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: source);
    if (this.mounted) {
      setState(() {
        file = File(imageFile.path);
      });
      await upload_picture(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _selectOptionBottomSheet() {
      double width = MediaQuery.of(context).size.width;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              color: whiteColor,
              child: Wrap(
                children: <Widget>[
                  Container(
                    child: Container(
                      padding: EdgeInsets.all(fixPadding),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Choose Option',
                              textAlign: TextAlign.center,
                              style: black18BoldTextStyle,
                            ),
                          ),
                          heightSpace,
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: fixPadding),
                            width: width,
                            height: 1.0,
                            color: greyColor.withOpacity(0.5),
                          ),
                          InkWell(
                            onTap: () {
                              selectprofilepic(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: width,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.black.withOpacity(0.7),
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('Camera', style: black14MediumTextStyle),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectprofilepic(ImageSource.gallery);
                            },
                            child: Container(
                              width: width,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.photo_album,
                                    color: Colors.black.withOpacity(0.7),
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Upload from Gallery',
                                    style: black14MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }

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
                      controller: name,
                      onChanged: (value) {
                        setState(() {
                          processDetail.itemName = value;
                        });
                      },
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
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDetails()))
                        .then((value) async {
                      processDetail.detailID = value;
                      await getdetailsbyid(value);
                    });
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
                    onChanged: (value) {},
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
                    onChanged: (value) {},
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
                    onChanged: (value) async {
                      num totalamount =
                          await getdetailsbyid(processDetail.detailID);
                      num totalprice = num.parse(net.text) *
                              num.parse(purity.text) *
                              0.01 *
                              num.parse(price.text) +
                          totalamount;
                      processDetail.total = totalprice;
                      amount.text = totalprice.toStringAsFixed(2);
                      if (card == process.length + 1 &&
                          !process.contains(processDetail)) {
                        process.add(processDetail);
                      } else if (card == process.length &&
                          process.contains(processDetail)) {
                        int index = process.indexWhere((element) {
                          if (element.detailID == processDetail.detailID)
                            return true;
                          return false;
                        });
                        process[index] = processDetail;
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
                        _selectOptionBottomSheet();
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
