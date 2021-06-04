class SignupData {
  String username;
  String customer_mobile;
  String customer_Password;

  SignupData.data({this.username, this.customer_mobile, this.customer_Password});
  SignupData();

  factory SignupData.fromJson(Map<String, dynamic> signupData) {
    return SignupData.data(
        username: signupData['username'],
        customer_mobile: signupData['customer_mobile'],
        customer_Password: signupData['customer_Password']);
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'customer_mobile': customer_mobile,
    'customer_Password': customer_Password,
  };
}