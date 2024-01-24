class Validation {
  static String validateEmail(String email) {
    // Biểu thức chính quy kiểm tra định dạng email
    String emailPattern = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';

    if (email == null || !RegExp(emailPattern).hasMatch(email)) {
      return 'Email invalid';
    }
    return '';
  }

  static String validateUsername(String username) {
    if (username.length < 4 || username.length > 50) {
      return 'Nằm trong khoản 4 đến 50 ký tự';
    }

    if (RegExp('[A-Z]').hasMatch(username) ||
        RegExp('[^a-zA-Z0-9]').hasMatch(username)) {
      return 'không được tồn tại ký tự hoa hoặc ký tự đặt biệt';
    }
    return '';
  }

  static String validatePassword(String password) {
    if (password.length < 6) {
      return 'Mật khẩu không được bé hơn 6 ký tự và lớn hơn 50 ký tự';
    }

    if (!RegExp('[A-Z]').hasMatch(password) ||
        !RegExp('[a-z]').hasMatch(password) ||
        !RegExp('[0-9]').hasMatch(password) ||
        !RegExp('[^a-zA-Z0-9]').hasMatch(password)) {
      return 'Mật khẩu phải chưa ký tự in hoa, thương, số và ký tự đặt biệt';
    }
    return '';
  }
}
