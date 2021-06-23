class Util {

  static String sanitizePhone(String phone) {
    phone = phone.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '');

    return phone;
  }

  static String sanitizeCpfCnpj(String cpfCnpj) {
    cpfCnpj = cpfCnpj.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '').replaceAll('.', '').replaceAll('/', '');

    return cpfCnpj;
  }
  static String sanitizeCEP(String cep) {
    cep = cep.replaceAll('.', '').replaceAll('-', '').replaceAll(' ', '');

    return cep;
  }

}