import 'package:flutter/material.dart';
import 'package:pos_app/models/product.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({
    Key? key, required this.name,
    required this.function,
    this.product,
    this.mayus = true
  }) : super(key: key);
  
  final String name;
  bool mayus = true;
  Product? product;
  void Function()? function;
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: function,
      child: (product == null) ? Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Colors.redAccent,),
            const SizedBox(width: 10,),
            Text( name , style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.w600),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.red,)
            
          ],
        ),
    
      )
      : Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.restaurant_menu, color: Colors.redAccent,),
                      const SizedBox(width: 10,),
                      Text( name.capitalize() ,overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600),),
                      
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.attach_money, color: Colors.redAccent,),
                      const SizedBox(width: 10,),
                      Text( product!.precio1.toString() , style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600),),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap:function,
              child: Container(
                height: double.infinity,
                width: 70,
                decoration: const BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),),
                child: const Center(child:Icon(Icons.note_alt, color: Colors.white,size: 30,))
                ),
            )

          ],
        ),
    
      )
    );
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}