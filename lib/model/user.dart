class UserInfo{
  String? userID;
  String? userNickName;
  String? userProfileImagePath;

  UserInfo(
  {
    required this.userID,
    required this.userNickName,
    required this.userProfileImagePath
  });

  // Map<String, dynamic> toJson() => {
  //   "name": name,
  //   "profilePhoto": profilePhoto,
  //   "email": email,
  //   "uid": uid,
  // };
}