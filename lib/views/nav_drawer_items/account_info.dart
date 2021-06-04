import 'dart:convert';
import 'dart:io';
import 'package:haarway_app/views/edit_profile/edit_profile_page.dart';
import 'package:haarway_app/views/forgot_password/forgot_password_page.dart';
import 'package:haarway_app/views/nav_drawer_items/edit_password.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:haarway_app/global_variables.dart' as global;
import 'package:url_launcher/url_launcher.dart';

class AccountinfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountinfoScreen> {
  CommonData commonData = new CommonData();
  Data myUserData = new Data();
  bool isNum;
  bool ismob;
  bool ismail;
/*  bool fb_visibility;
  bool tw_visibility;
  bool sk_visibility;
  bool goog_visibility;
  bool linkd_visibility;
  bool inst_visibility;*/
  bool socialLink_visibility;

  String imageUrlName;
  String name;
  String bio;
  String membersince;
  String address;
  String phone;
  String email;
  String website;
  String phvified;
  String phvifiedcolour;
  String emailverified;
  String emailverifiedcolour;
  String fblink;
  var twlink;
  var sklink;
  var googlink;
  var linkdlink;
  var instlink;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDataFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Account info",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24.0),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.redAccent, Colors.redAccent]
                          // borderRadius: new BorderRadius.circular(30.0),
                        )
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                imageUrlName,
                              ),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              name,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                    child: ListTile(
                      title: Text(
                        "Bio :",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        bio,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                    child: ListTile(
                      title: Text(
                        "Member Since :",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        membersince,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                    child: ListTile(
                      title: Text(
                        "Address :",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        address,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Image.asset(
                                "assets/call.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                phone,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                child:InkWell(
                                  onTap: () {
                                    _displayMobTextInputDialog(context, phone);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18),
                                  ),
                                )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.0,
                                height: 26.0,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(16.0),
                                  //color: Colors.green,
                                  border: Border.all(
                                      color: (phvified == "Verified") ? Colors.green : Colors.redAccent
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      phvified,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.0, color: (phvified == "Verified") ? Colors.green : Colors.redAccent),
                                    ),
//                                    Spacer(),
//                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Image.asset(
                                "assets/mail.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150.0,
                                child: Text(
                                  email,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal, fontSize: 16.0),

                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                child:InkWell(
                                  onTap: () {
                                    _displayEmailTextInputDialog(context, email);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18),
                                  ),
                                )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.0,
                                height: 26.0,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(16.0),
                                  //color: Colors.green,
                                  border: Border.all(
                                      color: (emailverified == "Verified") ? Colors.green : Colors.redAccent
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      emailverified,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.0, color: (emailverified == "Verified") ? Colors.green : Colors.redAccent),
                                    ),
//                                    Spacer(),
//                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isNum,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Image.asset(
                                  "assets/globe.png",
                                  height: 24.0,
                                  width: 24.0,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  website,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal, fontSize: 16.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: socialLink_visibility,
                    child: Container(
                        child: ListTile(
                          title: Text(
                            "Social media",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ))
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                          visible: (fblink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(fblink);
                                    },
                                    child: Image.asset(
                                      "assets/f_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Visibility(
                          visible: (twlink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(twlink);
                                    },
                                    child: Image.asset(
                                      "assets/t_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Visibility(
                          visible: (instlink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(instlink);
                                    },
                                    child: Image.asset(
                                      "assets/in_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Visibility(
                          visible: (sklink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(sklink);
                                    },
                                    child: Image.asset(
                                      "assets/sk_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Visibility(
                          visible: (googlink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(googlink);
                                    },
                                    child: Image.asset(
                                      "assets/youtb_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Visibility(
                          visible: (linkdlink == "") ? false : true,
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      // const url = uri.parse(fblink);
                                      launchURL(linkdlink);
                                    },
                                    child: Image.asset(
                                      "assets/lin_logo.png",
                                      height: 44.0,
                                      width: 44.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      )

                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 300.0,
                  height: 42.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.redAccent),
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      String myCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfilePage()),
                      );

                      setState(() {
                        // cityName = myCity;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.poppins(
                              fontSize: 18.0, color: Colors.redAccent),
                        ),
//                                    Spacer(),
//                                    Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 300.0,
                  height: 42.0,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.redAccent),
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      String myCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditPasswordPage()),
                      );

                      setState(() {
                        // cityName = myCity;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Edit Password",
                          style: GoogleFonts.poppins(
                              fontSize: 18.0, color: Colors.redAccent),
                        ),
//                                    Spacer(),
//                                    Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }


  void getUserDataFromLocal() async {
    Future<String> userData = commonData.getUser();
    String myUserString = await userData;
    Map jsonData = new Map();
    jsonData = jsonDecode(myUserString);
    setState(() {
      myUserData = Data.fromJson(jsonData);
      print(myUserData);
      if (myUserData != null) {
        print("myUseraccinfo==============::: $myUserData");
        name = myUserData.customer_name;
        DateTime now = DateTime.now();
        DateTime dt = DateTime.parse(myUserData.create_date);
        membersince = DateFormat('MMMM yyyy').format(dt);
        //membersince = myUserData.create_date;
        bio = myUserData.customer_short_bio;
        phone = myUserData.customer_mobile;
        website= myUserData.website;
        email = myUserData.customer_email;

        address = myUserData.customer_locality+", "+myUserData.customer_zipcode;
        imageUrlName = myUserData.customer_profile_photo;
        if (website == null || website == ""|| website.isEmpty){
          isNum = false;
        }else{
          isNum = true;
        }
        ismob = false;
        if (myUserData.mobile_activated == "0"){
          phvified = "Not verified";
        }else{
          phvified = "Verified";
        }
        if (myUserData.email_activated == "0"){
          emailverified = "Not verified";
        }else{
          emailverified = "Verified";
        }

        //social media links
        fblink = global.facebook_link;
        twlink = global.twitter_link;
        instlink = global.instagram_link;
        googlink = global.google_link;
        sklink = global.skype_link;
        linkdlink = global.linkedin_link;

        /*if (fblink == null || fblink == ""|| fblink.isEmpty){
          fb_visibility = false;
        }else{
          fb_visibility = true;
        }
        print("fblink==============::: $fblink");
        if (twlink == null || twlink == ""|| twlink.isEmpty){
          tw_visibility = false;
        }else{
          tw_visibility = true;
        }

        if (instlink == null || instlink == ""|| instlink.isEmpty){
          inst_visibility = false;
        }else{
          inst_visibility = true;
        }
        if (googlink == null || googlink == ""|| googlink.isEmpty){
          goog_visibility = false;
        }else{
          goog_visibility = true;
        }
        if (sklink == null || sklink == ""|| sklink.isEmpty){
          sk_visibility = false;
        }else{
          sk_visibility = true;
        }
        if (linkdlink == null || linkdlink == ""|| linkdlink.isEmpty){
          linkd_visibility = false;
        }else{
          linkd_visibility = true;
        }
*/
        if(fblink == "" &&
            twlink == "" &&
            instlink == "" &&
            googlink == "" &&
            sklink == "" &&
            linkdlink == ""){
          socialLink_visibility = false;
        }else{
          socialLink_visibility = true;
        }
      }
    });
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future<void> _displayMobTextInputDialog(BuildContext context, String mob) async {
  TextEditingController mobTextController = new TextEditingController();
  mobTextController.text = mob;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mobile Number'),
          content: TextField(
              controller: mobTextController,
              onChanged: (value) {
                // setState(() {
                //  valueText = value;
                // });
              },
              decoration: InputDecoration(hintText: "Enter mobile number"),
              keyboardType: TextInputType.phone
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('CANCEL'),
              onPressed: () {
                //  setState(() {
                Navigator.pop(context);
                //  });
              },
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('Update & Verify'),
              onPressed: () {
                String mobNo = mobTextController.text.trim();
                String cstId = global.customerID;
                if (mobNo == null || mobNo == "" || mobNo.isEmpty) {
                  Toast.show(
                      "Please enter mobile number", context,
                      gravity: 1,
                      duration: Toast.LENGTH_LONG);
                  return;
                }
                else if(mobNo.length != 10)
                {
                  Toast.show(
                      "Please Enter valid Mobile Number", context,
                      gravity: 1,
                      duration: Toast.LENGTH_LONG);
                }
                else{
                  Provider.of<ProviderModel>(context,
                      listen: false)
                      .editmobilenumberRequest(
                      cstId,
                      mobNo,
                      context);
                }
              },
            ),
          ],
        );
      });
}

Future<void> _displayEmailTextInputDialog(BuildContext context, String email) async {
  TextEditingController emailTextController = new TextEditingController();
  emailTextController.text = email;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Email'),
          content: TextField(
              controller: emailTextController,
              onChanged: (value) {
                // setState(() {
                //  valueText = value;
                // });
              },
              decoration: InputDecoration(hintText: "Enter email "),
              keyboardType: TextInputType.emailAddress
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('CANCEL'),
              onPressed: () {
                //  setState(() {
                Navigator.pop(context);
                //  });
              },
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('Update & Verify'),
              onPressed: () {
                String emailID = emailTextController.text.trim();
                String cstId = global.customerID;
                if (emailID == null || emailID == "" || emailID.isEmpty) {
                  Toast.show(
                      "Please enter email", context,
                      gravity: 1,
                      duration: Toast.LENGTH_LONG);
                  return;
                }
                // else if(!emailID.contains(RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b")))
                else if(!emailID.toLowerCase().contains(RegExp(r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+(?:[a-zA-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|co.in|asia|cat|coop|edu|int|pro|tel)\b")))
                  //else if(!emailID.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))
                    {
                  Toast.show(
                      "Please enter valid email", context,
                      gravity: 1,
                      duration: Toast.LENGTH_LONG);
                  return;
                }
                else{
                  Provider.of<ProviderModel>(context,
                      listen: false)
                      .editemailRequest(
                      cstId,
                      emailID,
                      context);
                }
              },
            ),
          ],
        );
      });
}

