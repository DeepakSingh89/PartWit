
class LoginModel {
  var status;
  var message;
  var token;
  var rememberDevice;
  var role;
  UserInfo? userInfo;

  LoginModel(
      {this.status,
        this.message,
        this.token,
        this.rememberDevice,
        this.role,
        this.userInfo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    rememberDevice = json['remember_device'];
    role = json['role'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    data['remember_device'] = this.rememberDevice;
    data['role'] = this.role;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  var id;
  var name;
  var email;
  var emailVerifiedAt;
  var deviceId;
  var phone;
  var profileImage;
  var bannerImage;
  var customerId;
  var isEmailVerified;
  var notificationStatus;
  var isEnable;
  var lat;
  var lng;
  var isRegistrationComplete;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var profilePic;

  UserInfo(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.deviceId,
        this.phone,
        this.profileImage,
        this.bannerImage,
        this.customerId,
        this.isEmailVerified,
        this.notificationStatus,
        this.isEnable,
        this.lat,
        this.lng,
        this.isRegistrationComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.profilePic});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    deviceId = json['device_id'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    bannerImage = json['banner_image'];
    customerId = json['customer_id'];
    isEmailVerified = json['isEmailVerified'];
    notificationStatus = json['notification_status'];
    isEnable = json['is_enable'];
    lat = json['lat'];
    lng = json['lng'];
    isRegistrationComplete = json['isRegistrationComplete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['device_id'] = this.deviceId;
    data['phone'] = this.phone;
    data['profile_image'] = this.profileImage;
    data['banner_image'] = this.bannerImage;
    data['customer_id'] = this.customerId;
    data['isEmailVerified'] = this.isEmailVerified;
    data['notification_status'] = this.notificationStatus;
    data['is_enable'] = this.isEnable;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['isRegistrationComplete'] = this.isRegistrationComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}