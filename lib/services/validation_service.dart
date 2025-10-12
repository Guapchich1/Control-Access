class ValidationService {
  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите код';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите имя';
    }
    if (!(RegExp(r'^[а-яёА-ЯЁa-zA-Z]+$').hasMatch(value) )) {
      return 'Разрешены только буквы';
    }
    if (value.length < 2) {
      return 'Имя должно содержать минимум 2 буквы';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите пароль';
    }
    return null;
  }
}