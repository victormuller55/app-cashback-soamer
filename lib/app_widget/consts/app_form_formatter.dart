import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormFormatters {
  static MaskTextInputFormatter cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter cnpjFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter nfeFormatter = MaskTextInputFormatter(mask: '#### #### #### #### #### #### #### #### #### #### ####', filter: {"#": RegExp(r'[0-9A-Za-z]')});
  static MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9A-Za-z]')});
}
