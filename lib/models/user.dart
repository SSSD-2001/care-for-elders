class User {
    String userId;
    String name;
    String email;
    String password; // In a real app, passwords should be hashed and handled securely
    String phoneNumber;
    DateTime dateOfBirth;
    String address;
    List<String> emergencyContacts; // List of contact names or numbers
    String bloodType;
    List<String> allergies;
    String role; 

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
    required this.emergencyContacts,
    required this.bloodType,
    required this.allergies,
    required this.role,
  });

  // Convert object to a Map (like JSON)
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'address': address,
        'emergencyContacts': emergencyContacts, 
        'bloodType': bloodType,
        'allergies': allergies,
        'role': role,
      };

  // Convert Map back to object
  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        dateOfBirth: json['dateOfBirth'],
        address: json['address'],
        emergencyContacts: List<String>.from(json['emergencyContacts'] ?? []),
        bloodType: json['bloodType'],
        allergies: List<String>.from(json['allergies'] ?? []),
        role: json['role'],
      );
}