class Util {

  static String sanitizePhone(String phone) {
    phone = phone.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '');

    return phone;
  }

}