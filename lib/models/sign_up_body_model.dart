class SignUpBody {
  String name, phone, email, password;
  SignUpBody({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
