import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pos_app/bloc/orders/orders_bloc.dart';
import 'package:pos_app/models/order.dart';
import 'package:pos_app/widgets/order_item.dart';
import 'package:provider/provider.dart';



class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.redAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            children: const [
              Text(
                "Pedido",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red,
        body: Stack(
          children: [_buildCards(), _sendButton(context, width)],
        ));
  }

   _sendButton(BuildContext context, var width ) {
    return Positioned(
      bottom: 0,
      child: InkWell(
        onTap: () {
            final ordersBloc = Provider.of<OrdersBloc>(context, listen:false);
            if(ordersBloc.state.orders.isNotEmpty){
              ordersBloc.sendOrder();
              Fluttertoast.showToast(msg: "Imprimiendo recibo...", backgroundColor: const Color.fromRGBO(153, 121, 99, 1));
            }
          },
        child: Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          width: width,
          height: 100,
          child: const Center(
            child: Text("Vender",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCards() {
    
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        List<Order> orders = state.orders;
        return (orders.isNotEmpty) ? Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: (1 / 0.4),
            // ignore: prefer_const_literals_to_create_immutables
            children: List.generate(orders.length, (index) {
              Order order = orders[index];
              return OrderItem(order: order,);
            })
          ),
        ) : const Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: Center(child: Text("Agrega productos al pedido :)", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),),
        );
      },
    );
  }

}


