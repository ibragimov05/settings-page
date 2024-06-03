import 'package:settings_page/models/user_info.dart';

class UserInfoViewModel {
  UserInfo _userInfo = UserInfo(
    userName: 'userName',
    userSurname: 'userSurname',
    phoneNumber: 'phoneNumber',
    profilePictureUrl: 'https://belon.club/uploads/posts/2023-04/1681531491_belon-club-p-obichnii-muzhchina-pinterest-1.jpg',
  );

  UserInfo get userInfo {
    return _userInfo;
  }

  void editUserInfo({
    required String newName,
    required String newSurname,
    required String newNumber,
    required String newPicture,
  }) {
    _userInfo.userName = newName;
    _userInfo.userSurname = newSurname;
    _userInfo.phoneNumber = newNumber;
    _userInfo.profilePictureUrl = newPicture;
  }
}
