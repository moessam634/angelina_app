class MyValidators {
  static String? fullNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'الاسم لا يمكن أن يكون فارغًا';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'يجب أن يكون الاسم بين 3 و 20 حرفًا';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'يجب أن يتكون رقم الهاتف من 11 رقمًا';
    }
    return null;
  }

  static String? simpleRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName لا يمكن أن يكون فارغًا';
    }
    return null;
  }

  static String? streetValidator(String? value) => simpleRequired(value, 'اسم الشارع');
  static String? buildingValidator(String? value) => simpleRequired(value, 'رقم المبنى');
  static String? cityValidator(String? value) => simpleRequired(value, 'المدينة');
  static String? countryValidator(String? value) => simpleRequired(value, 'الدولة');
  static String? floorValidator(String? value) => simpleRequired(value, 'رقم الدور');
  static String? apartmentValidator(String? value) => simpleRequired(value, 'رقم الشقة');
}
