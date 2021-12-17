class userdata {
  String sId;
  String name;
  String email;
  Role role;
  String password;
  String phoneNumber;
  String panNumber;
  String aadharNumber;
  String address;
  int iV;

  userdata(
      {this.sId,
      this.name,
      this.email,
      this.role,
      this.password,
      this.phoneNumber,
      this.panNumber,
      this.aadharNumber,
      this.address,
      this.iV});

  userdata.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    panNumber = json['panNumber'];
    aadharNumber = json['aadharNumber'];
    address = json['address'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['panNumber'] = this.panNumber;
    data['aadharNumber'] = this.aadharNumber;
    data['address'] = this.address;
    data['__v'] = this.iV;
    return data;
  }
}

class Role {
  List<Permissions> permissions;
  String status;
  String sId;
  String roleName;
  String createdAt;
  String updatedAt;
  int iV;

  Role(
      {this.permissions,
      this.status,
      this.sId,
      this.roleName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Role.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      permissions = new List<Permissions>();
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
    roleName = json['role_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['role_name'] = this.roleName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Permissions {
  String status;
  String sId;
  String permissionName;
  String createdAt;
  String updatedAt;
  int iV;

  Permissions(
      {this.status,
      this.sId,
      this.permissionName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Permissions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    permissionName = json['permission_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['permission_name'] = this.permissionName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

userdata Userdata = userdata();
