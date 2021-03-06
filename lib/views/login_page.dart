import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/login_data.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:haarway_app/views/forgot_password/forgot_password_page.dart';
import 'package:haarway_app/views/home/home_page.dart';
import 'package:haarway_app/views/sign_up.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as globals;


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passTextController = new TextEditingController();
  bool isNum = true;
  bool passVisible;
//  bool isNumeric(String s) => s != null && int.tryParse(s) != null;
  bool _saving = false;
  bool otpFlag = false;
  bool isMobile = false;
  bool passwordInvisible = true;
//  globals.isLoggedIn = false;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  bool isValidEmail(String s) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);
  }

  void _submit(LoginData userLogin, String username, BuildContext context) {
    setState(() {
      _saving = true;
      globals.isLoggedIn = _saving;
    });

    //Simulate a service call
    print('submitting to backend...');
    Provider.of<ProviderModel>(context, listen: false)
        .otpRequst(userLogin, username, context, otpFlag);
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
        globals.isLoggedIn = _saving;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ModalProgressHUD(
          child: _buildLoginWidget(context),
          inAsyncCall: globals.isLoggedIn,
          dismissible: true,
        ));
  }

  Widget _buildLoginWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 200.0,    //changed by jp new is 20
        ),
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
//    headerText("Login"),
                    SizedBox(height: 10.0),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                            child: Image.asset(
                              "assets/haarway.png",
                              height: 30.0,
                              width: 150.0,
                            ))),
                    SizedBox(
                      height: 50.0,
                    ),

//    labelText("Email address"),
                    SizedBox(height: 10.0),
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
                            is;*/
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUpPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
//                              ForgotPasswordPage
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ForgotPasswordPage()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
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
                                onPressed: () async {
                                  String username;
                                  String pass;
                                  if (isMobile == false) {
                                    username = mobileTextController.text.trim();
                                    pass = passTextController.text.trim();

                                    print(username);
                                    print(pass);

                                    if (username == null || username == "" || username.isEmpty) {
                                      Toast.show(
                                          "Please enter Mobile No/Email ID", context,
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
                                          "Please enter password", context,
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
                                    else if (username != null &&
                                        pass != null &&
                                        username != "" &&
                                        pass != "") {
                                      LoginData logindata = new LoginData();
                                      logindata.username = username;
                                      logindata.customer_Password = pass;

                                      Provider.of<ProviderModel>(context,
                                          listen: false)
                                          .postRequest(logindata, username,
                                          pass, context);
                                    }
                                  }

                                  if (isMobile == true) {
                                    username = mobileTextController.text;
                                    if (username == null || username == "") {
                                      Toast.show(
                                          "Please enter Mobile No/Email ID", context,  //Ch BY JP
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                    }
                                    else if(username.length != 10)
                                    {
                                      Toast.show(
                                          "Please Enter valid Mobile Number", context,  //Ch BY JP
                                          gravity: 1,
                                          duration: Toast.LENGTH_LONG);
                                    }

                                    else if (username != null && username != "") {
                                      LoginData userLogin = new LoginData();
                                      userLogin.username = username;
                                      //userLogin.customer_mobile = username;
                                      final otpSigned =
                                      await SmsAutoFill().getAppSignature;
                                      print(
                                          "App Signature==============>>>>>>>> $otpSigned");
//                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OTPScreen(mobileNumber: "$username",)));

                                      _submit(userLogin, username, context);
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
                                color: new CommonData().colorFromHex("#e95d5d"),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );

//        Padding(
//        padding: const EdgeInsets.all(20.0);
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

