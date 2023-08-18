import 'package:acti_provider/providers/provider.dart';
import 'package:acti_provider/themes/app_theme.dart';
import 'package:acti_provider/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class CheckSessionScreen extends StatelessWidget {
   
  const CheckSessionScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: FutureBuilder(
        future: UtilProvider.rtp.checkSession(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return LogoWidget();
          }
          if(snapshot.data == 1){
            Future.microtask(() =>  Navigator.pushReplacementNamed(context, '/Home'));
          }else {
           Future.microtask(() =>  Navigator.pushReplacementNamed(context, '/Login'));
          }
          return LogoWidget();  
        },
      ),
    );
  }
}