class EmergencyService{
  String serviceId;
  String name;
  String phoneNumber;
  String address;
  String dserviceType;

  EmergencyService({
    required this.serviceId,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.dserviceType,
  });
  // Convert object to a Map (like JSON)
  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
        'dserviceType': dserviceType,
      };
  // Convert Map back to object
  factory EmergencyService.fromJson(Map<String, dynamic> json) => EmergencyService(
        serviceId: json['serviceId'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        dserviceType: json['dserviceType'],
      );
}