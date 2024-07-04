import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_form_formatter.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/formatters.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_bloc.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/loading.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  CadastroBloc bloc = CadastroBloc();

  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController senha = TextEditingController();

  bool termosAceitos = false;

  void _salvar() {

    VendedorModel vendedorModel = VendedorModel(
      nome: nome.text,
      email: email.text,
      celular: somenteNumeros(celular.text),
      cpf: somenteNumeros(cpf.text),
      senha: senha.text,
    );

    bloc.add(CadastroSalvarEvent(vendedorModel));
  }

  void _validar() {
    if (verificaCampoFormVazio(controllers: [nome, email, cpf, senha])) {
      if (validaEmail(email.text)) {
        if (validaCPF(cpf.text)) {
          if (termosAceitos) {
            _salvar();
          } else {
            showSnackbarWarning(message: AppStrings.concordeComOsTermosDeUsoEPoliticaDePrivacidade);
          }
        } else {
          showSnackbarWarning( message: AppStrings.cpfInvalido);
        }
      } else {
        showSnackbarWarning(message: AppStrings.emailInvalido);
      }
    } else {
      showSnackbarWarning(message: AppStrings.todosOsCamposSaoObrigatorios);
    }
  }

  Widget _body() {
    return Column(
      children: [
        appSizedBoxHeight(70),
        formFieldPadrao(context, controller: nome, hint: AppStrings.nome, width: 300, textInputType: TextInputType.name),
        formFieldPadrao(context, controller: email, hint: AppStrings.email, width: 300, textInputType: TextInputType.emailAddress),
        formFieldPadrao(context, controller: celular, hint: AppStrings.celular, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.phoneFormatter),
        formFieldPadrao(context, controller: cpf, hint: AppStrings.cpf, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.cpfFormatter),
        formFieldPadrao(context, controller: senha, hint: AppStrings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
        SizedBox(
          width: 330,
          child: CheckboxListTile(
            value: termosAceitos,
            title: appText(AppStrings.concordoTermosPoliticas, color: Colors.white, bold: false),
            onChanged: (value) => setState(() => termosAceitos = !termosAceitos),
            checkColor: AppColors.primaryColor,
            fillColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        appSizedBoxHeight(AppSpacing.medium),
        elevatedButtonPadrao(
          function: () => _validar(),
          appText(AppStrings.cadastrar.toUpperCase(), color: AppColors.primaryColor, bold: true, fontSize: AppFontSizes.small),
        ),
        appSizedBoxHeight(AppSpacing.normal),
        appElevatedButtonText(
          AppStrings.jaTenhoConta.toUpperCase(),
          color: AppColors.primaryColor.withOpacity(0.5),
          textColor: Colors.white,
          function: () => open(screen: const EntrarScreen(), closePrevious: true),
        ),
        appSizedBoxHeight(AppSpacing.medium),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<CadastroBloc, CadastroState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CadastroLoadingState:
            return loading(color: Colors.white);
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundCadastroLogin(
        context,
        child: _bodyBuilder(),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
