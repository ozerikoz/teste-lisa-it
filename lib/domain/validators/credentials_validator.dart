/// This class is responsible for validating user credentials
class CredentialsValidator {
  /// Validates an email field
  ///
  /// Returns null if the email is valid, or an error message if it's invalid

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu email.';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Insira um endereço de email válido.';
    }
    return null;
  }

  /// Validates a password field
  ///
  /// Returns null if the password is valid, or an error message if it's invalid
  ///
  /// - [password] is the password to validate
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Digite sua senha.';
    }
    if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }
}
