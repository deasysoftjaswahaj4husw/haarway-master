import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haarway_app/model/review/review_request.dart';
import 'package:haarway_app/providers/provider_model.dart';
import 'package:haarway_app/utils/common_data.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AddReviewPage extends StatefulWidget {
  final String seoUrl;
  final String customerID;
  final String rating;

  AddReviewPage(
      {@required this.seoUrl,
        @required this.customerID,
        @required this.rating});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController reviewTitleTextController = new TextEditingController();
  TextEditingController reviewDescTextController = new TextEditingController();
  TextEditingController ratingTextController = new TextEditingController();

  void addReview(BuildContext context, ReviewRequest reviewRequest) async {
    var response = await Provider.of<ProviderModel>(context, listen: false)
        .addReviewApiCall(context, reviewRequest);
    Map responseData = new Map();
    responseData = jsonDecode(response.body);
  }
  var ratingpoint = 0.0;
  var ratingvalue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Text(
                      "Add Your Review ",
                      style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ))),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: reviewTitleTextController,
                decoration: InputDecoration(
                    hintText: "Enter Review title",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SmoothStarRating(
                rating: ratingpoint,
                isReadOnly: false,
                size: 45,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star,
                defaultIconData: Icons.star_border,
                starCount: 5,
                color: Colors.redAccent,
                borderColor: Colors.redAccent,
                allowHalfRating: false,
                spacing: 3.0,
                onRated: (value) {
                  ratingvalue = value;
                  print("rating value -> $value");
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: reviewDescTextController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Enter Review Description",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            SizedBox(
              height: 10.0,
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
                          String rTitle;
                          String rDesc;
                          String rating;
                          String pattern = r'(^[1-5]*$)';
                          RegExp regExp = new RegExp(pattern);
                          ReviewRequest reviewRequest = new ReviewRequest();

                          rTitle = reviewTitleTextController.text;
                          rDesc = reviewDescTextController.text;
                          rating = ratingvalue.toString();
                          // int rating = int.parse(ratingTextController.text);

                          if (rTitle == null || rTitle == "") {
                            Toast.show(
                                "Please enter review  title", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }
                          else if (rating == null || rating == "" || rating == "0.0" ) {
                            Toast.show(
                                "Please enter rating", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }
                          else if (rDesc == null || rDesc == "") {
                            Toast.show(
                                "Please enter review  Description", context,
                                gravity: 1, duration: Toast.LENGTH_SHORT);
                            return;
                          }
                          else  {
                            print("rating value after submit -> $rating");
                            reviewRequest.reviewTitle = rTitle;
                            reviewRequest.reviewDesc = rDesc;
                            reviewRequest.customerID = widget.customerID;
                            reviewRequest.seoUrl = widget.seoUrl;
                            reviewRequest.reviewRating = rating;
                            Provider.of<ProviderModel>(context, listen: false)
                                .addReviewApiCall(context, reviewRequest);
                            //Navigator.of(context).pop();


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
                              color: new CommonData().colorFromHex("#e95d5d"),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}

