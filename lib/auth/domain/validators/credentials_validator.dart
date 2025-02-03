import 'package:lucid_validation/lucid_validation.dart';
import '../dtos/credentials.dart';

class CredentialsValidator extends LucidValidator<Credentials> {
  CredentialsValidator() {
    ruleFor((user) => user.email, key: 'email').notEmpty().validEmail();

    ruleFor((user) => user.password, key: 'password') //
        .notEmpty(message: 'Senha é obrigatória')
        .minLength(8, message: 'Deve ter pelo menos 8 caracteres')
        .mustHaveLowercase(message: 'Deve ter pelo menos uma letra minúscula')
        .mustHaveUppercase(message: 'Deve ter pelo menos uma letra maiúscula')
        .mustHaveNumber(message: 'Deve ter pelo menos um número')
        .mustHaveSpecialCharacter(
            message: 'Deve ter pelo menos um caractere especial');

    ruleFor((user) => user.confirmPassword, key: 'confirmPassword') //
        .notEmpty(message: 'Confirm password is required')
        .equalTo((user) => user.password, message: 'Senhas não conferem');
  }
}
