import 'dart:convert';

class LoginState {
  final bool isLoggedIn; // never persisted
  final String? lastLogin;

  LoginState({
    this.isLoggedIn = false,
    this.lastLogin,
  });

  factory LoginState.initial() {
    return LoginState(isLoggedIn: false);
  }

  LoginState copyWith({
    bool? isLoggedIn,
    String? lastLogin,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLoggedIn': isLoggedIn,
      'lastLogin': lastLogin,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      isLoggedIn: map['isLoggedIn'] ?? false,
      lastLogin: map['lastLogin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) => LoginState.fromMap(json.decode(source));

  @override
  String toString() => 'LoginState(isLoggedIn: $isLoggedIn, lastLogin: $lastLogin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState && other.isLoggedIn == isLoggedIn && other.lastLogin == lastLogin;
  }

  @override
  int get hashCode => isLoggedIn.hashCode ^ lastLogin.hashCode;
}
