import 'package:acti_provider/providers/provider.dart';
import 'package:acti_provider/themes/app_theme.dart';
import 'package:acti_provider/util/util.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
         const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Image(image: AssetImage('assets/pokemon.png')),
          ),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
              ),
            ],
            child: const Login(),
          ),
        ],
      ),
    ));
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LFP = Provider.of<LoginFormProvider>(context);
    return SingleChildScrollView(
          
      child: Form(
        key: LoginFormProvider.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: AppTheme.baseInput(
                  hintText: 'Ingresa tu usuario', labelText: 'usuario'),
              onChanged: (value) => print(LFP.user = value),
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'Usuario debe de tener tres caracteres';
              },
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: AppTheme.baseInput(
                  hintText: 'Contraseña', labelText: 'contraseña'),
              obscureText: true,
              onChanged: (value) => print(LFP.password = value),
              validator: (value) {
                return (value != null && value.length >= 3)
                    ? null
                    : 'Usuario debe de tener tres caracteres';
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              

              onPressed: () async{
              FocusScope.of(context).unfocus();

              if(!LFP.isValidForm()) return;
              LFP.isLoading = true;
              await Future.delayed(Duration(seconds: 5));

              if (LFP.user != null && LFP.password != null){
                UtilProvider.rtp.saveStorage(usuario: LFP.user, password: LFP.password);
                final rest = await UtilProvider.rtp.saveStorage(usuario: LFP.user, password: LFP.password);
                if( rest ==1){
                  NotificationsService.toasMessage(msg: 'msg');
                        Dialogos.msgDialog(context: context,
                         texto: 'Bienvenido', 
                          dgt: DialogType.success,
                         onPress: 
                        (){
                          NotificationsService.showSnackBar(message: 'Bienvenido');
                        Navigator.pushNamed(context, '/Home');
                        }).show();
                }
                  
              }
              LFP.isLoading = false;
            }, 
            child: Text(LFP.isLoading ? 'Cargando...' : 'Ingresar'))
          ],
        ),
      ),
      ),
    );
  }
}
