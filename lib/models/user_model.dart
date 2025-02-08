class UserModel {
  final String id;
  final String username;
  final String profileImageUrl;
  final int followers;

  UserModel({
    required this.id,
    required this.username,
    required this.profileImageUrl,
    required this.followers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      profileImageUrl: json['profile_image_url'],
      followers: json['followers'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_image_url': profileImageUrl,
      'followers': followers,
    };
  }
}