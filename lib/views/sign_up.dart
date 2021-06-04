import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>  {
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passTextController = new TextEditingController();
  TextEditingController customerNameTextController =
  new TextEditingController();
  String tc;
  bool isNum = true;
  bool isMobile = false;
  bool _saving = false;
  bool checkbox_policy = false;
  bool passwordInvisible = false;
  //bool userNmNotContainNum = false;
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  bool isValidEmail(String s) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                      children: <Widget>[
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
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Center(
                                child: Text(
                                  " Create Account ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ))),
                        SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: customerNameTextController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                          ],
                          /*onChanged: (value) {
                            setState(() {
                              if (value != " ") isNum = isNumeric(value);
                            });
                          },*/
                          // onFieldSubmitted: (value){
                          //   isNum=true;
                          // },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff6f7f9),
                            /*errorText: isNum == true
                                ? "Name should contain alphabets only"
                                : null,*/
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
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
                          controller: mobileTextController,
                          textAlign: TextAlign.left,
//                      maxLength: 10,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() {
                              if (value != " ")
                                isNum = !isValidEmail(value);
                              isMobile=isNumeric(value);
                              /* else
                                value = "";*/
                            });
                          },
//                      onFieldSubmitted: (value) {
//
//                      },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff6f7f9),
                            errorText: new CommonData().validateEmail(
                                mobileTextController.text.trim(), isMobile) ==
                                false
                                ? getErrorMessage(
                                isMobile, mobileTextController.text.trim())
                                : null,
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Mobile No/Email ID',          //Changed by Jp
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: const Color(0xffa8abc1), width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: const Color(0x80eb5b77),
                                  width: 1,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: const Color(0x80eb5b77),
                                  width: 1,
                                )),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Visibility(
                          visible: isNum == false ? true : false,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: const Color(0xfff6f7f9)),
                            child: TextFormField(
                              controller: passTextController,
                              obscureText: passwordInvisible,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15.0),
                                hintText: '**********',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: const Color(0xffa8abc1), width: 1)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordInvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordInvisible = !passwordInvisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidate: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkbox_policy,
                                  checkColor:
                                  Colors.white, // color of tick Mark
                                  activeColor: Colors.redAccent,
                                  onChanged: (bool value) {
                                    setState(() {
                                      checkbox_policy = value;
                                      if (value == true) {
                                        setState(() {
                                          tc = "1";
                                        });
//                            checkboxFemale = false;
//                            checkboxOthers = false;
                                      }
                                    });
                                  }),
                              Expanded(
                                child: Text(
                                  "I agree to the terms and conditions and privacy policy",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                      String username;
                                      String cust_name;
                                      String pass;

                                      username = mobileTextController.text.trim();
                                      cust_name = customerNameTextController.text.trim();
                                      pass = passTextController.text.trim();

                                      if(isMobile == false){
                                        if (cust_name == null ||
                                            cust_name == "") {
                                          Toast.show(
                                              "please enter customer name",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        if (!cust_name.contains(RegExp(r'(^[a-zA-Z\\s ]*$)'))) {
                                          Toast.show(
                                              "Please enter valid customer name",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        else if (username == null ||
                                            username == "") {
                                          Toast.show(
                                              "Please enter Mobile No/Email ID",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        //Added by JP
                                        else if(!username.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))
                                        {
                                          Toast.show(
                                              "Please enter valid email", context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }

                                        else if (pass == null || pass == "") {
                                          Toast.show(
                                              "please enter password",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        else if(!pass.contains(RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,}$")))
                                        {
                                          String title = "Please enter valid password";
                                          String errorMessage = "Password must be contain minimum 6 characters, at least one uppercase letter, one lowercase letter, one number and one special character ";
                                          CommonData().showAlertjp(context, title, errorMessage);

                                          /*   Toast.show(
                                                "Password must contain minimum 6 and maximum 10 characters, at least one uppercase letter, one lowercase letter, one number and one special character. ", context,
                                                gravity: 1,
                                                duration: Toast.LENGTH_LONG);
                                            return;  */
                                        }
                                        else if (checkbox_policy != true) {
                                          Toast.show(
                                              "Please Accept the T & C of company policy",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_SHORT);
                                          return;
                                        }

                                        else if (cust_name != null &&
                                            cust_name != "" &&
                                            username != null &&
                                            username != "" &&
                                            pass != null &&
                                            pass != "" &&
                                            tc != null &&
                                            tc != "") {
                                          Provider.of<ProviderModel>(context,
                                              listen: false)
                                              .registerRequest(
                                              cust_name,
                                              username,
                                              pass,
                                              tc,
                                              isNum,
                                              context);
                                        }
                                      }
                                      else if(isMobile == true){

                                        if (cust_name == null ||
                                            cust_name == "") {
                                          Toast.show(
                                              "please enter customer name",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        if (!cust_name.contains(RegExp(r'(^[a-zA-Z\\s ]*$)'))) {
                                          Toast.show(
                                              "Please enter valid customer name",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        else if (username == null ||
                                            username == "") {
                                          Toast.show(
                                              "Please enter Mobile No/Email ID",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                          return;
                                        }
                                        else if(username.length != 10)
                                        {
                                          Toast.show(
                                              "Please Enter valid Mobile Number", context,  //Ch BY JP
                                              gravity: 1,
                                              duration: Toast.LENGTH_LONG);
                                        }
                                        else if (checkbox_policy != true) {
                                          Toast.show(
                                              "Please Accept the T & C of company policy",
                                              context,
                                              gravity: 1,
                                              duration: Toast.LENGTH_SHORT);
                                          return;
                                        }

                                        else if(cust_name != null &&
                                            cust_name != "" &&
                                            username != null &&
                                            username != "" &&
                                            tc != null &&
                                            tc != "") {
                                          Provider.of<ProviderModel>(context,
                                              listen: false)
                                              .registerRequest(
                                              cust_name,
                                              username,
                                              pass,
                                              tc,
                                              isNum,
                                              context);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16.0),
                                    ),
                                    color: checkbox_policy == true
                                        ? new CommonData()
                                        .colorFromHex("#e95d5d")
                                        : Colors.grey,
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
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
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(25.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "OR",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            'Sign Up with Social Media',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 52.0,
                                width: 52.0,
                                child: InkWell(
                                    onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SocialLoginPage()));
                                    },
                                    child: Image.asset(
                                      "assets/google_login.png",
                                    )),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 18.0, right: 10.0),
                                child: Container(
                                    height: 42.0,
                                    width: 42.0,
                                    child: InkWell(
                                        onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SocialLoginPage()));
                                        },
                                        child:
                                        Image.asset("assets/fb_logo.png"))),
                              ),
                            ],
                          ),
                        )
                      ],
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

  String getPasswordError(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return "";
    } else if (mobileNumber.length < 10) {
      return 'please enter the valid Mobile Number';
    } else if (mobileNumber.length > 10) {
      return 'please enter the valid Mobile Number';
    } else
      return '';
  }

  String getErrorMessage(bool isNum, String mobile) {
    if (isMobile == true && mobile.length != 10) {
      return "Please Enter valid Mobile Number";
    } else if (isMobile == false)
      return "Please enter valid email";
    else
      return "";
  }
}
