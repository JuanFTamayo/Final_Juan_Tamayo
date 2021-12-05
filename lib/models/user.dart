

class User {
  
  String imageId = '';
  String imageFullPath = '';
  int userType = 1;
  int loginType = 0;
  String fullName = '';
  
 
  String id = '';
  String userName = '';
  String email = '';
  
  User({
    
    
    required this.imageId,
    required this.imageFullPath,
    required this.userType,
    required this.loginType,
    required this.fullName,
    
    
    required this.id,
    required this.userName,
    required this.email,
    
  });

  User.fromJson(Map<String, dynamic> json) {
   
    
    imageId = json['imageId'];
    imageFullPath = json['imageFullPath'];
    userType = json['userType'];
    loginType = json['loginType'];
    fullName = json['fullName'];
    
    
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    
    
    data['imageId'] = this.imageId;
    data['imageFullPath'] = this.imageFullPath;
    data['userType'] = this.userType;
    data['loginType'] = this.loginType;
    data['fullName'] = this.fullName;
    
    
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    
    return data;
  }
}