class UserProfile {
  final String username;
  final String email;
  final String? whatsapp;
  final String? telegram;
  final String? facebook;

  UserProfile({
    required this.username,
    required this.email,
    this.whatsapp,
    this.telegram,
    this.facebook,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      telegram: json['telegram'],
      facebook: json['facebook'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "whatsapp": whatsapp,
      "telegram": telegram,
      "facebook": facebook,
    };
  }
}