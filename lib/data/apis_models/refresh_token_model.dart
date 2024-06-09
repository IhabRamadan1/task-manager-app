class RefreshTokenModel {
  String? token;
  String? refreshToken;

  RefreshTokenModel({this.token, this.refreshToken});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
