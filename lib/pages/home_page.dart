import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ Colors.redAccent, Colors.white ],
              stops: [1, 1]
          )),
              
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: true,
          title: Text('Mi abuela', style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white, 
              fontSize: 24,
              fontWeight: FontWeight.bold
            )
          )),
        ),
        
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: (height*0.04), bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                OptionWidget(route: 'products', color: Colors.redAccent, title: 'Productos', icon: Icon(Icons.fastfood, color: Colors.white, size: 50),),
                OptionWidget(route: 'cart', color: Colors.redAccent, title: 'Pedido', icon: Icon(Icons.note_alt, color: Colors.white, size: 50,)),
                OptionWidget(route: 'products', color: Colors.redAccent, title: 'Ordenes', icon: Icon(Icons.description , color: Colors.white, size: 50)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {

  const OptionWidget({
    
    Key? key, 
    
    required this.route, 
    required this.color, 
    required this.title, 
    required this.icon,

  }) : super(key: key);
  
  final String route;
  final Color color;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width; 
    return GestureDetector(
      child: Container(
        width: screenWith,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
                
              ],
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        padding: const EdgeInsets.all(20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title, 
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize:20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              )
            ),
            icon
          ],
        )
      ),

      onTap: (){
        Navigator.pushNamed(context, route);
      },
    );
  }
}