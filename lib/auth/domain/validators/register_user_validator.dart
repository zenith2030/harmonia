import 'package:harmonia/auth/domain/dtos/register_user.dart';
import 'package:lucid_validation/lucid_validation.dart';

class RegisterUserValidator extends LucidValidator<RegisterUser> {
  RegisterUserValidator() {
    ruleFor((user) => user.name, key: 'name').notEmpty().minLength(3);

    ruleFor((user) => user.email, key: 'email').notEmpty().validEmail();

    ruleFor((user) => user.password, key: 'password') //
        .notEmpty(message: 'Senha é obrigatória')
        .minLength(8, message: 'Deve ter pelo menos 8 caracteres')
        .mustHaveLowercase(message: 'Deve ter pelo menos uma letra minúscula')
        .mustHaveUppercase(message: 'Deve ter pelo menos uma letra maiúscula')
        .mustHaveNumber(message: 'Deve ter pelo menos um número')
        .mustHaveSpecialCharacter(
            message: 'Deve ter pelo menos um caractere especial');

    ruleFor((user) => user.passwordConfirm, key: 'passwordConfirm') //
        .notEmpty(message: 'Confirm password is required')
        .equalTo((user) => user.password, message: 'Senhas não conferem');
  }
}
