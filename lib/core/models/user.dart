class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String companyName;
  final String taxId;
  final String companyOption;
  final String password;
  final String phoneNumber;
  final String requestedRole;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyName,
    required this.taxId,
    required this.companyOption,
    required this.password,
    required this.phoneNumber,
    required this.requestedRole,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      companyName: json['companyName'] as String,
      taxId: json['taxId'] as String? ?? '',
      companyOption: json['companyOption'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      requestedRole: json['requestedRole'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'companyName': companyName,
      'taxId': taxId,
      'companyOption': companyOption,
      'password': password,
      'phoneNumber': phoneNumber,
      'requestedRole': requestedRole,
    };
  }

  String get fullName => '$firstName $lastName';
}