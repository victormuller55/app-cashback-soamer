import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_bloc.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_screen.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

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
          showSnackbarWarning(message: AppStrings.cpfInvalido);
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
        appSizedBox(height: 70),
        appFormField(context, controller: nome, hint: AppStrings.nome, width: 300, textInputType: TextInputType.name),
        appFormField(context, controller: email, hint: AppStrings.email, width: 300, textInputType: TextInputType.emailAddress),
        appFormField(context, controller: celular, hint: AppStrings.celular, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.phoneFormatter),
        appFormField(context, controller: cpf, hint: AppStrings.cpf, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.cpfFormatter),
        appFormField(context, controller: senha, hint: AppStrings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
        SizedBox(
          width: 330,
          child: CheckboxListTile(
            value: termosAceitos,
            title: appText(AppStrings.concordoTermosPoliticas, color: Colors.white, bold: false),
            onChanged: (value) => setState(() => termosAceitos = !termosAceitos),
            checkColor: cashboost.AppColors.primaryColor,
            fillColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        appSizedBox(height: AppSpacing.medium),
        appElevatedButton(
          function: () => _validar(),
          appText(AppStrings.cadastrar.toUpperCase(), color: cashboost.AppColors.primaryColor, bold: true, fontSize: AppFontSizes.small),
        ),
        appSizedBox(height: AppSpacing.normal),
        appElevatedButtonText(
          AppStrings.jaTenhoConta.toUpperCase(),
          color: cashboost.AppColors.primaryColor.withOpacity(0.5),
          textColor: Colors.white,
          function: () => open(screen: const EntrarScreen(), closePrevious: true),
        ),
        appSizedBox(height: AppSpacing.medium),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<CadastroBloc, CadastroState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CadastroLoadingState:
            return appLoading(
              child: loadingCircular(),
              color: Colors.white,
            );
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
