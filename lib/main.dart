import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_order_delivery_app/provider/app_provider.dart';
import 'package:food_order_delivery_app/screens/auth_ui/welcome/welcome.dart';
import 'package:food_order_delivery_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';
import 'firebase_helper/firebase_auth.dart';
import 'firebase_helper/firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //payment
       Stripe.publishableKey="";
  await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Rush',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
