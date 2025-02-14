String? passwordValidator(value) {
  if (value.isEmpty) {
    return 'password-required';
  }
  if (value.length < 8) {
    return 'password-length';
  }
  return null;
}

String? emailValidator(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'invalid-email';
  } else {
    return null;
  }
}

String? defaultValidator(value) {
  if (value.isEmpty) {
    return 'This field is required';
  }
  return null;
}
