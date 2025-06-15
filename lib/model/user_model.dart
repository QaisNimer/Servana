class UserModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String imageUrl;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.imageUrl,
  });

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    String? imageUrl,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
