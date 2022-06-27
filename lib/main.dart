import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/bloc/mercaderiaSabores/mercaderiasabores_bloc.dart';
import 'package:pos_app/bloc/orders/orders_bloc.dart';
import 'package:pos_app/bloc/groups/groups_bloc.dart';
import 'package:pos_app/bloc/products/products_bloc.dart';
import 'package:pos_app/bloc/sabores/sabores_bloc.dart';
import 'package:pos_app/pages/cart_page.dart';
import 'package:pos_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() { 
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData windowData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    windowData = windowData.copyWith(
      textScaleFactor: windowData.textScaleFactor > 1.0 ? 1.0 : windowData.textScaleFactor,
    );
    return MultiProvider(
      providers:  
      [
        
        BlocProvider(create: (_) => GroupsBloc()),
        BlocProvider(create: (_) => ProductsBloc()),
        BlocProvider(create: (_) => OrdersBloc()),
        BlocProvider(create: (_) => SaboresBloc()),
        BlocProvider(create: (_) => MercaderiasaboresBloc()),
        
        
      ],

      child: Builder(builder: (context) { 
        return MediaQuery(
          data: windowData,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            initialRoute: "home",
            routes: {
              "home" : (context) => const HomePage(),
              "cart" : (context) => const CartPage()
            },
          )
        );
      })
    );
}}
