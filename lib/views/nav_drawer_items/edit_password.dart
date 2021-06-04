import 'package:custom_dropdown/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:haarway_app/global_variables.dart' as global;

class EditPasswordPage extends StatefulWidget {
  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController passTextController = new TextEditingController();
  TextEditingController newpassTextController = new TextEditingController();
  TextEditingController conpassTextController = new TextEditingController();

  bool passwordInvisible1 = true;
  bool passwordInvisible2 = true;
  bool passwordInvisible3 = true;

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
          "",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24.0),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
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
                      padding:
                      const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 40.0),
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
                                      " Edit password ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ))),
                            SizedBox(
                              height: 30.0,
                            ),
                            SizedBox(height: 10.0),
                            Visibility(
                              visible: (global.custmPass == "") ? false : true,
                              child: TextFormField(
                                controller: passTextController,
                                obscureText: passwordInvisible1,
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xfff6f7f9),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 0.0, style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  hintText: 'Current Password',
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
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordInvisible1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordInvisible1 = !passwordInvisible1;
                                      });
                                    },
                                  ),
                                ),
                                autovalidate: true,
                              ),
                            ),

                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: newpassTextController,
                              obscureText: passwordInvisible2,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xfff6f7f9),
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 0.0, style: BorderStyle.none),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                contentPadding: EdgeInsets.only(left: 15.0),
                                hintText: 'New Password',
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordInvisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordInvisible2 = !passwordInvisible2;
                                    });
                                  },
                                ),
                              ),
                              autovalidate: true,
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: conpassTextController,
                              obscureText: passwordInvisible3,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xfff6f7f9),
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 0.0, style: BorderStyle.none),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                contentPadding: EdgeInsets.only(left: 15.0),
                                hintText: 'Confirm password',
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordInvisible3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordInvisible3 = !passwordInvisible3;
                                    });
                                  },
                                ),
                              ),
                              autovalidate: true,
                            ),
                            SizedBox(height: 20.0),
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
                                          String pass;
                                          String newpass;
                                          String confpass;

                                          pass = passTextController.text.trim();
                                          newpass = newpassTextController.text.trim();
                                          confpass = conpassTextController.text.trim();
                                          String cstId = global.customerID;
                                          print("customerID $cstId");

                                          if (pass == null || pass == "") {
                                            Toast.show(
                                                "please enter current password",
                                                context,
                                                gravity: 1,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }
                                          /* else if(!pass.contains(RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,}$")))
                                          {
                                            String title = "Please enter valid password";
                                            String errorMessage = "Password must be contain minimum 6 characters, at least one uppercase letter, one lowercase letter, one number and one special character ";
                                            CommonData().showAlertjp(context, title, errorMessage);
                                          }*/
                                          else if (newpass == null || newpass == "") {
                                            Toast.show(
                                                "please enter new password",
                                                context,
                                                gravity: 1,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }
                                          else if(!newpass.contains(RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,}$")))
                                          {
                                            String title = "Please enter valid password";
                                            String errorMessage = "Password must be contain minimum 6 characters, at least one uppercase letter, one lowercase letter, one number and one special character ";
                                            CommonData().showAlertjp(context, title, errorMessage);
                                          }
                                          else if (confpass == null || confpass == "") {
                                            Toast.show(
                                                "please enter confirm password",
                                                context,
                                                gravity: 1,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }
                                          else if (newpass != confpass){
                                            Toast.show(
                                                "New Password and Confirm Password must be same",
                                                context,
                                                gravity: 1,
                                                duration: Toast.LENGTH_LONG);
                                            return;
                                          }
                                          else {
                                            Provider.of<ProviderModel>(context,
                                                listen: false)
                                                .editPasswordRequest(
                                                cstId,
                                                newpass,
                                                confpass,
                                                context);
                                          }

                                        },
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                        color: new CommonData()
                                            .colorFromHex("#e95d5d"),
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
                          ],
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
    );
  }

}

