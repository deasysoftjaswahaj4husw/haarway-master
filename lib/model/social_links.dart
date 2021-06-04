import 'dart:core';
import 'dart:core';
import 'package:haarway_app/global_variables.dart' as global;

class SocialLinks {
  String customerID;
  String socialID;
  String social_url;
  String social_name;
  String font_awesome;
  String sort_order;
  String status;

  SocialLinks(
      {this.customerID,
        this.socialID,
        this.social_url,
        this.social_name,
        this.font_awesome,
        this.sort_order,
        this.status});

  factory SocialLinks.fromJson(Map<String, dynamic> socialData) {
    if(socialData['socialID'] == "1"){
      String fb = socialData['social_url'];
      global.facebook_link = socialData['social_url'];
      print("fbc $fb");
    }
    if(socialData['socialID'] == "2"){
      String twt = socialData['social_url'];
      global.twitter_link = socialData['social_url'];
      print("tw $twt");
    }
    if(socialData['socialID'] == "3"){
      String ts = socialData['social_url'];
      // global.facebook_link = socialData['social_url'];
      print("ts $ts");
    }
    if(socialData['socialID'] == "4"){
      String ins = socialData['social_url'];
      global.instagram_link = socialData['social_url'];
      print("inst $ins");
    }
    if(socialData['socialID'] == "5"){
      String sky = socialData['social_url'];
      global.skype_link = socialData['social_url'];
      print("skyp $sky");
    }
    if(socialData['socialID'] == "6"){
      String googl = socialData['social_url'];
      global.google_link = socialData['social_url'];
      print("google $googl");
    }
    if(socialData['socialID'] == "7"){
      String lin = socialData['social_url'];
      global.linkedin_link = socialData['social_url'];
      print("linked $lin");
    }

    return SocialLinks(
        customerID: socialData['customerID'],
        socialID: socialData['socialID'],
        social_url: socialData['social_url'],
        social_name: socialData['social_name'],
        font_awesome: socialData['font_awsome'],
        sort_order: socialData['sort_order'],
        status: socialData['status']);
  }
}
