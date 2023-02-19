class ValidadorCpf {
  static bool validar(String cpf) {
    // Remova quaisquer caracteres que não sejam números
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Verifique se o CPF tem 11 dígitos
    if (cpf.length != 11) {
      return false;
    }
    
    // Verifique se todos os dígitos são iguais (o que não é permitido em CPFs válidos)
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }
    
    // Verifique os dígitos verificadores
    var soma = 0;
    for (var i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    var resto = soma % 11;
    var dv1 = resto < 2 ? 0 : 11 - resto;
    if (dv1 != int.parse(cpf[9])) {
      return false;
    }
    
    soma = 0;
    for (var i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    resto = soma % 11;
    var dv2 = resto < 2 ? 0 : 11 - resto;
    if (dv2 != int.parse(cpf[10])) {
      return false;
    }
    
    // Se chegou até aqui, o CPF é válido
    return true;
  }
}
