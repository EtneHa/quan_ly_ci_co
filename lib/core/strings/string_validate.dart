class StringValidate {
  static String? validatePhoneNumber(String? value, {bool isRequired = true}) {
    if (value == null || value.isEmpty) {
      if (isRequired) return 'This field is required';
      return null;
    } else if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
      return 'Please enter a valid phone';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (value == null || value.isEmpty) {
      if (isRequired) return 'This field is required';
      return null;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value, {bool isRequired = true}) {
    if (value == null || value.isEmpty) {
      if (isRequired) return 'This field is required';
      return null;
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateDateTime(String? value, {bool isRequired = true}) {
    if ((value == null || value.isEmpty)) {
      if (isRequired) return 'This field is required';
      return null;
    } else if (!RegExp(r'^\d{2}\/\d{2}\/\d{4}$').hasMatch(value)) {
      return 'Please enter a valid date';
    }
    return null;
  }
}
