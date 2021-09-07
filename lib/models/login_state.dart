import 'dart:convert';

class LoginState {
  final bool incorrectPasswordError;
  final bool isLoggedIn;
  final String? lastLogin;
  final bool loadingPasswordCheck;
  LoginState({
    required this.incorrectPasswordError,
    required this.isLoggedIn,
    this.lastLogin,
    required this.loadingPasswordCheck,
  });

  factory LoginState.initial() {
    return LoginState(incorrectPasswordError: false, isLoggedIn: false, loadingPasswordCheck: false);
  }

  LoginState copyWith({
    bool? incorrectPasswordError,
    bool? isLoggedIn,
    String? lastLogin,
    bool? loadingPasswordCheck,
  }) {
    return LoginState(
      incorrectPasswordError: incorrectPasswordError ?? this.incorrectPasswordError,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      lastLogin: lastLogin ?? this.lastLogin,
      loadingPasswordCheck: loadingPasswordCheck ?? this.loadingPasswordCheck,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'incorrectPasswordError': incorrectPasswordError,
      'isLoggedIn': isLoggedIn,
      'lastLogin': lastLogin,
      'loadingPasswordCheck': loadingPasswordCheck,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      incorrectPasswordError: map['incorrectPasswordError'],
      isLoggedIn: map['isLoggedIn'],
      lastLogin: map['lastLogin'],
      loadingPasswordCheck: map['loadingPasswordCheck'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) => LoginState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginState(incorrectPasswordError: $incorrectPasswordError, isLoggedIn: $isLoggedIn, lastLogin: $lastLogin, loadingPasswordCheck: $loadingPasswordCheck)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.incorrectPasswordError == incorrectPasswordError &&
        other.isLoggedIn == isLoggedIn &&
        other.lastLogin == lastLogin &&
        other.loadingPasswordCheck == loadingPasswordCheck;
  }

  @override
  int get hashCode {
    return incorrectPasswordError.hashCode ^
        isLoggedIn.hashCode ^
        lastLogin.hashCode ^
        loadingPasswordCheck.hashCode;
  }
}
