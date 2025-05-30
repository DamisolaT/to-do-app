class FormValidator {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName field is required';
    }
    return null;
  }

  static String? validateMinWordCount(String? value, int minWords) {
    if (value == null || value.split(RegExp(r'\s+')).length < minWords) {
      return 'Description must be at least $minWords words';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final phoneRegExp = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static Future<String?> validateDisplayName(String username) async {
    // Simulate a database check (replace with Firestore query)
    await Future.delayed(const Duration(seconds: 1));
    final existingUsernames = ['john_doe', 'jane_smith', 'marri_user'];
    if (existingUsernames.contains(username.toLowerCase())) {
      return 'This username is already taken';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateCustom(String? value) {
    if (value == null || value.isEmpty) {
      return 'Custom validation message';
    }
    return null;
  }

  static String? validateAmount(String? value, dynamic balance) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }

    double amount = double.tryParse(value) ?? 0;
    if (amount > balance) {
      return 'Amount exceeds available balance';
    }

    return null;
  }
}

String capitalizeFirstLetter(String? text) {
  if (text == null || text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneRegex = RegExp(r'^[0-9]{8,}$');
  return phoneRegex.hasMatch(phoneNumber);
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (!isValidPhoneNumber(value)) {
    return 'Enter a valid phone number';
  }
  return null;
}