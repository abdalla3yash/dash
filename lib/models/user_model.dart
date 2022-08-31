class UserModel {
  int id, orderCount;
  String name, email, phone;

  UserModel({
    required this.id,
    required this.orderCount,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        orderCount: json['order_count'],
        email: json['email'],
        name: json['f_name'],
        phone: json['phone']);
  }
}
