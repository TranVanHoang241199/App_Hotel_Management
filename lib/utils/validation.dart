class Validation {
  static String validateEmail(String email) {
    // Biểu thức chính quy kiểm tra định dạng email
    String emailPattern = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';

    if (email == null || !RegExp(emailPattern).hasMatch(email)) {
      return 'vui long nhap theo dinh dang _@_._';
    }
    return '';
  }

  static String validateUsername(String username) {
    // if (AuthRepository.checkUsername(username) == 1) {
    //   return 'tai khoan da ton tai';
    // }

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

  static String validateFullName(String fullName) {
    if (fullName.length > 100) {
      return 'Ten khong duoc lon hon 100 ky tu';
    }
    return '';
  }

  static String validatePhone(String phone) {
    if (!RegExp('[0-9]').hasMatch(phone)) {
      return 'vui long nhap so dien thoai';
    }
    return '';
  }
}
