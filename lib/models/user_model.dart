class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String status;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.status = 'Ativo',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'],
      password: map['password'] ?? '',
      status: map['status'] ?? 'Ativo',
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
