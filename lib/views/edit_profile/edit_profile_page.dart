import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/data.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/edit_profile/social_data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:haarway_app/global_variables.dart' as global;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController customerTextController = new TextEditingController();
  TextEditingController sortBioTextController = new TextEditingController();
  TextEditingController websiteTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController localityTextController = new TextEditingController();
  TextEditingController zipcodeTextController = new TextEditingController();
  TextEditingController facebookTextController = new TextEditingController();
  TextEditingController twitterTextController = new TextEditingController();
  TextEditingController instaTextController = new TextEditingController();
  TextEditingController googleTextController = new TextEditingController();
  TextEditingController skypeTextController = new TextEditingController();
  TextEditingController linkedInTextController = new TextEditingController();
  File _image;
  CommonData commonData = new CommonData();
  Data myUserData = new Data();
  String custId;
  bool isEmailValid = true;
  bool isNameNum = false;
  bool isBioNum = false;
  bool islocalNum = false;
  bool iswebNum = false;
  bool isZipNum = true;
  GlobalKey editProfileKey;
  String imageFileName;
  String imageUrlName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDataFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: editProfileKey,
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
          "Edit Profile",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x0d000000),
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        spreadRadius: 0)
                  ],
                  color: const Color(0xffffffff)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 40.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Center(
                              child: Image.asset(
                                "assets/haarway.png",
                                height: 30.0,
                                width: 150.0,
                              ))),
                      SizedBox(height: 30.0),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey,
                                child: _image != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    _image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                  width: 100,
                                  height: 100,
                                  child: imageUrlName != null
                                      ? ClipRRect(

                                    borderRadius:
                                    BorderRadius.circular(50),
                                    child: Image.network(
                                      imageUrlName,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: customerTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        // onFieldSubmitted: (value) {
                        //   setState(() {
                        //     isNameNum = new CommonData().isNumeric(value);
                        //   });
                        // },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          // errorText: isNameNum == true
                          //     ? "Name should certain alphabets only"
                          //     : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Customer Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: sortBioTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        maxLines: 8,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isBioNum = new CommonData().isNumeric(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: isBioNum == true
                              ? "Bio should text alphabets only"
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0, top: 15),
                          hintText: 'Sort Bio...',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: websiteTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          setState(() {
                            iswebNum = new CommonData().isNumeric(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: iswebNum == true
                              ? "Website should text alphabets only"
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Website',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: emailTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isEmailValid =
                                new CommonData().validateEmail(value, false);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: isEmailValid == false
                              ? "Please enter valid email"
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: localityTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          setState(() {
                            islocalNum = new CommonData().isNumeric(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: islocalNum == true
                              ? " Locality should text only "
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Locality',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: zipcodeTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isZipNum = new CommonData().isNumeric(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
                          errorText: isZipNum == false
                              ? " ZipCode should Numeric value only "
                              : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'ZipCode',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Social Media Links",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: facebookTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'facebook Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: twitterTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'twitter Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: instaTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Instagram Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: googleTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Google Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: skypeTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Skype Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: linkedInTextController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
//                            setState(() {
//                              isNum = isNumeric(value);
//                            });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff6f7f9),
//                            errorText: new CommonData().validateEmail(
//                                mobileTextController.text, isNum) ==
//                                false
//                                ? getErrorMessage(isNum)
//                                : null,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'LinkedIn Link',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: const Color(0xffa8abc1), width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0x80eb5b77),
                                width: 1,
                              )),
                        ),
                      ),
                      //submit button
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 24.0,
                          right: 24.0,
                        ),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 325.0,
                                height: 52.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    String customerName;
                                    String sort_bio;
                                    String website;
                                    String email;
                                    String locality;
                                    String zipcode;
                                    String fb_link;
                                    String tw_link;
                                    String inst_link;
                                    String sky_link;
                                    String goog_link;
                                    String linked_link;
                                    SocialDataModel socialDataModel;
//                                    = new SocialDataModel();
                                    List<SocialDataModel> socialDataList =
                                    new List<SocialDataModel>();

                                    customerName = customerTextController.text;
                                    sort_bio = sortBioTextController.text;
                                    website = websiteTextController.text;
                                    email = emailTextController.text.trim();
                                    locality = localityTextController.text;
                                    zipcode = zipcodeTextController.text;
                                    //Social media
                                    fb_link = facebookTextController.text.trim();
                                    tw_link = twitterTextController.text.trim();
                                    inst_link = instaTextController.text.trim();
                                    sky_link = skypeTextController.text.trim();
                                    goog_link = googleTextController.text.trim();
                                    linked_link = linkedInTextController.text.trim();

                                    print("customerName: $customerName");
                                    print("sort_bio: $sort_bio");
                                    print("email: $email");
                                    print("locality: $locality");
                                    print("zipcode: $zipcode");
                                    print("imageFileNamesubmit: $imageUrlName");

//                                    if (facebookTextController.text != null) {
                                    new SocialDataModel().socialID = "1";
                                    new SocialDataModel().socialUrl =
                                        facebookTextController.text;
                                    socialDataList.add(socialDataModel);
//                                    }
//                                    if (twitterTextController.text != null) {
                                    new SocialDataModel().socialID = "2";
                                    new SocialDataModel().socialUrl =
                                        twitterTextController.text;
                                    socialDataList.add(socialDataModel);
//                                    }
//                                    if (instaTextController.text != null) {
                                    new SocialDataModel().socialID = "3";
                                    new SocialDataModel().socialUrl =
                                        instaTextController.text;
                                    socialDataList.add(socialDataModel);
//                                    }
//                                    if (googleTextController.text != null) {
                                    new SocialDataModel().socialID = "4";
                                    new SocialDataModel().socialUrl =
                                        googleTextController.text;
                                    socialDataList.add(socialDataModel);
//                                    }
//                                    if (skypeTextController.text != null) {
                                    new SocialDataModel().socialID = "5";
                                    new SocialDataModel().socialUrl =
                                        skypeTextController.text;
                                    socialDataList.add(socialDataModel);
//                                    }
//                                    if (linkedInTextController.text != null) {
                                    new SocialDataModel().socialID = "6";
                                    new SocialDataModel().socialUrl =
                                        linkedInTextController.text;
                                    socialDataList.add(socialDataModel);

                                    if (customerName == null ||
                                        customerName == "") {
                                      Toast.show(
                                          "please enter customer name",
                                          context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(website != "" && !website.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid website link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else if (email == null || email == "") {
                                      Toast.show(
                                          "please enter  email", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else if(!email.toLowerCase().contains(RegExp(r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+(?:[a-zA-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|co.in|asia|cat|coop|edu|int|pro|tel)\b")))
                                      //else if(!email.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))
                                        {
                                      Toast.show(
                                          "Please enter valid email", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else if (locality == null || locality == "") {
                                      Toast.show(
                                          "please enter locality", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else if (zipcode == null || zipcode == "") {
                                      Toast.show(
                                          "please enter zip code", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }

                                    else if(!zipcode.contains(RegExp(r"^[1-9][0-9]{5}$")))
                                    {
                                      Toast.show(
                                          "please enter valid zip code", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(fb_link != "" && !fb_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid facebook link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(tw_link != "" && !tw_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid twitter link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(inst_link != "" && !inst_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid instagram link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(sky_link != "" && !sky_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid skype link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(goog_link != "" && !goog_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid google link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else  if(linked_link != "" && !linked_link.contains(RegExp(r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+(\.[a-z]{2,}){1,3}(#?\/?[a-zA-Z0-9#]+)*\/?(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-%]+&?)?$"))){
                                      Toast.show(
                                          "Please enter valid LinkedIn link", context,
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                      return;
                                    }
                                    else if (customerName != null &&
                                        customerName != "" &&
//                                        sort_bio != null &&
//                                        sort_bio != "" &&
                                        email != null &&
                                        email != "" &&
//                                        website != null &&
//                                        website != "" &&
                                        locality != null &&
                                        locality != "" &&
                                        zipcode != null &&
                                        zipcode != ""
                                    ) {
                                      if(imageFileName == null || imageFileName == ""){
                                        imageFileName = imageUrlName;
                                        Provider.of<ProviderModel>(context,
                                            listen: false)
                                            .editProfileApiCall(
                                            socialDataList,
                                            custId,
                                            customerName,
                                            sort_bio,
                                            email,
                                            website,
                                            locality,
                                            zipcode,
                                            fb_link,
                                            tw_link,
                                            inst_link,
                                            sky_link,
                                            goog_link,
                                            linked_link,
                                            global.imageFileName,
                                            context,
                                            editProfileKey);
                                        _image = null;

                                      }
                                      else{
                                        print("imageUrlforsubmitcase2==>> $imageFileName");
                                        Provider.of<ProviderModel>(context,
                                            listen: false)
                                            .editProfileApiCall(
                                            socialDataList,
                                            custId,
                                            customerName,
                                            sort_bio,
                                            email,
                                            website,
                                            locality,
                                            zipcode,
                                            fb_link,
                                            tw_link,
                                            inst_link,
                                            sky_link,
                                            goog_link,
                                            linked_link,
                                            global.imageFileName,
                                            context,
                                            editProfileKey);
                                        _image = null;
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16.0),
                                  ),
                                  color:
                                  new CommonData().colorFromHex("#e95d5d"),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(
                                        color: new CommonData()
                                            .colorFromHex("#e95d5d"),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    String imageUrl;
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 600);

    setState(() {
      _image = image;
    });
    if (_image != null) {
      imageFileName = await Provider.of<ProviderModel>(context, listen: false)
          .uploadFile(_image, context);
      print('imageFileName: $imageFileName');
    }
  }

  _imgFromGallery() async {
    String imageUrl;
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 600);

    setState(() {
      _image = image;
    });

    if (_image != null) {
      imageFileName = await Provider.of<ProviderModel>(context, listen: false)
          .uploadFile(_image, context);
      print('imageFileName: $imageFileName');
    }
  }

  _showPicker(context) {
//    String imageName;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
        _image = null;
        print("myUserData==============::: $myUserData");

        customerTextController.text = myUserData.customer_name;
        sortBioTextController.text = myUserData.customer_short_bio;
        websiteTextController.text = myUserData.website;
        emailTextController.text = myUserData.customer_email;
        localityTextController.text = myUserData.customer_locality;
        zipcodeTextController.text = myUserData.customer_zipcode;
        imageUrlName = myUserData.customer_profile_photo;
        print(zipcodeTextController.text);

        //social media links
        facebookTextController.text = global.facebook_link;
        twitterTextController.text = global.twitter_link;
        instaTextController.text = global.instagram_link;
        googleTextController.text = global.google_link;
        skypeTextController.text = global.skype_link;
        linkedInTextController.text = global.linkedin_link;


      }
      custId = myUserData.customerID;
    });
  }
}
