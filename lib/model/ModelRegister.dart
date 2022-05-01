class ModeRegister {
  var status;
  var message;
  var isRegistrationComplete;
  var rememberDevice;
  var token;
  var role;
  UserInfo? userInfo;

  ModeRegister(
      {this.status,
        this.message,
        this.isRegistrationComplete,
        this.rememberDevice,
        this.token,
        this.role,
        this.userInfo});

  ModeRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isRegistrationComplete = json['isRegistrationComplete'];
    rememberDevice = json['remember_device'];
    token = json['token'];
    role = json['role'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['isRegistrationComplete'] = this.isRegistrationComplete;
    data['remember_device'] = this.rememberDevice;
    data['token'] = this.token;
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
  // var profileImage;
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
  var plan;
  var rating;

  UserInfo(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.deviceId,
        this.phone,
        // this.profileImage,
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
        this.profilePic,
        this.plan,
        this.rating,

      });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    deviceId = json['device_id'];
    phone = json['phone'];
    // profileImage = json['profile_image'];
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
    plan = json['plan'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['device_id'] = this.deviceId;
    data['phone'] = this.phone;
    // data['profile_image'] = this.profileImage;
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
    data['plan'] = this.plan;
    data['rating'] = this.rating;
    return data;
  }
}

















/*
class ModeRegister {
  var status = false;
  var token = "";
  Data? data;

  ModeRegister(this.status, this.token, this.data);

  ModeRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'] == null ? false : json['status'];
    token = json['token'] == null ? '' : json['token'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var email;
  var name;
  var updatedAt;
  var createdAt;
  var id;
  var profilePic;

  Data(
      {this.email,
      this.name,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'] == null ? '' : json['email'];
    name = json['name'] == null ? '' : json['name'];
    updatedAt = json['updated_at'] == null ? '' : json['updated_at'];
    createdAt = json['created_at'] == null ? '' : json['created_at'];
    id = json['id'] == null ? '' : json['id'];
    profilePic = json['profile_pic'] == null ? '' : json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
*/
