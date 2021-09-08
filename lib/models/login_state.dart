import 'dart:convert';

class LoginState {
  final bool incorrectPasswordError;
  final bool isLoggedIn; // never persisted
  final String? lastLogin;
  final String? firstTimeLogin;
  final bool loadingPasswordCheck;

  LoginState({
    this.incorrectPasswordError = false,
    this.isLoggedIn = false,
    this.lastLogin,
    this.firstTimeLogin,
    this.loadingPasswordCheck = false,
  });

  factory LoginState.initial() {
    return LoginState(incorrectPasswordError: false, isLoggedIn: false, loadingPasswordCheck: false);
  }

  LoginState copyWith({
    bool? incorrectPasswordError,
    bool? isLoggedIn,
    String? lastLogin,
    String? firstTimeLogin,
    bool? loadingPasswordCheck,
  }) {
    return LoginState(
      incorrectPasswordError: incorrectPasswordError ?? this.incorrectPasswordError,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      lastLogin: lastLogin ?? this.lastLogin,
      firstTimeLogin: firstTimeLogin ?? this.firstTimeLogin,
      loadingPasswordCheck: loadingPasswordCheck ?? this.loadingPasswordCheck,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'incorrectPasswordError': incorrectPasswordError,
      'lastLogin': lastLogin,
      'firstTimeLogin': firstTimeLogin,
      'loadingPasswordCheck': loadingPasswordCheck,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      incorrectPasswordError: map['incorrectPasswordError'],
      lastLogin: map['lastLogin'],
      firstTimeLogin: map['firstTimeLogin'],
      loadingPasswordCheck: map['loadingPasswordCheck'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) => LoginState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginState(incorrectPasswordError: $incorrectPasswordError, isLoggedIn: $isLoggedIn, lastLogin: $lastLogin, firstTimeLogin: $firstTimeLogin, loadingPasswordCheck: $loadingPasswordCheck)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.incorrectPasswordError == incorrectPasswordError &&
        other.isLoggedIn == isLoggedIn &&
        other.lastLogin == lastLogin &&
        other.firstTimeLogin == firstTimeLogin &&
        other.loadingPasswordCheck == loadingPasswordCheck;
  }

  @override
  int get hashCode {
    return incorrectPasswordError.hashCode ^
        isLoggedIn.hashCode ^
        lastLogin.hashCode ^
        firstTimeLogin.hashCode ^
        loadingPasswordCheck.hashCode;
  }
}
