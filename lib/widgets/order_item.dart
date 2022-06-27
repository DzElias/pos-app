import 'package:flutter/material.dart';
import 'package:pos_app/bloc/orders/orders_bloc.dart';
import 'package:pos_app/models/order.dart';
import 'package:pos_app/models/sabor.dart';
import 'package:pos_app/widgets/item_widget.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    
    Key? key, required this.order,
  }) : super(key: key);

  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20))
            ),
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                GestureDetector(
                  onTap: ()
                  {
                    final orderBloc = Provider.of<OrdersBloc>(context, listen: false);
                    orderBloc.add(OnAddAmount(widget.order.mercaderiaId));
                  },
                  child: const Icon(Icons.keyboard_arrow_up, color: Colors.white,size: 30,)
                ),
                Text(widget.order.cantidad.toString(), style: const TextStyle(color: Colors.white, fontSize: 20),),
                GestureDetector(
                  onTap: ()
                  {
                    final orderBloc = Provider.of<OrdersBloc>(context, listen: false);
                    orderBloc.add(OnSubAmount(widget.order.mercaderiaId));
                  },
                  child: const Icon(Icons.keyboard_arrow_down, color: Colors.white,size: 30,)
                )
              ],
            ),
          ),
          SizedBox(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only( left: 10, top: 7.5),
                  child: Text(
                    widget.order.descripcion.capitalize().cutString(), 
                    style: const TextStyle(color: Colors.redAccent,overflow: TextOverflow.fade, fontSize: 15, fontWeight: FontWeight.w500),),
                ),

                widget.order.sabores.isNotEmpty ? _buildSabores() : SizedBox(),


                Container(
                  padding: const  EdgeInsets.only(bottom:7.5 , left: 10),
                  child: Text(
                    "Gs ${widget.order.subTotal.toString()}", 
                    style: const TextStyle(color: Colors.redAccent,overflow: TextOverflow.fade, fontSize: 18, fontWeight: FontWeight.w500),),
                ),

              ],
            ),
          ),
          
          const Spacer(),

          GestureDetector(
            onTap: (){
                final orderBloc = Provider.of<OrdersBloc>(context, listen: false);
                orderBloc.add(OnRemoveOrder(widget.order.mercaderiaId));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child:   Icon(Icons.delete_forever, color: Colors.redAccent, size: 35,),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildSabores() {
    List<String> saboresName = [];
    for(Sabor sabor in widget.order.sabores){
      
      saboresName.add(sabor.sabor);
      
    }

    String text = saboresName.toString().replaceAll('[', '').replaceAll(']', '').capitalize().cutString();


    return Container(
      padding: const EdgeInsets.only( left: 10),
      child: Text(
        text, 
        style: const TextStyle(
          color: Colors.redAccent,
          overflow: TextOverflow.fade, 
          fontSize: 15, 
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
extension StringExtension on String {
    String cutString() {
      if(length > 30){
        return '${this.substring(0, 27)}...';
      }
      return this;
    }
}