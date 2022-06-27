
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/bloc/mercaderiaSabores/mercaderiasabores_bloc.dart';
import 'package:pos_app/bloc/orders/orders_bloc.dart';
import 'package:pos_app/bloc/products/products_bloc.dart';
import 'package:pos_app/bloc/products/products_bloc.dart';
import 'package:pos_app/bloc/sabores/sabores_bloc.dart';
import 'package:pos_app/models/grupo.dart';
import 'package:pos_app/models/mercaderiaSabor.dart';
import 'package:pos_app/models/sabor.dart';
import 'package:pos_app/models/order.dart';
import 'package:pos_app/models/product.dart';
import 'package:pos_app/widgets/icon_btn.dart';
import 'package:pos_app/widgets/item_widget.dart';
import 'package:pos_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {

  const GroupPage({Key? key, required this.groupId, required this.groupName}) : super(key: key);

  final String groupId;
  final String groupName;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: 
          [
            Text(widget.groupName.capitalize() , style: const TextStyle(fontWeight: FontWeight.w500),),
            const Spacer(),
            const IconBtn()
          ],
        ),
        
      ),

      body: _buildProductsList()
    );
    
  }

  Color myColor = Colors.red;
  openAlertBox(List<Sabor> sabores, Product product) {

    List<Sabor> selected = [];
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Seleccionar sabor",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),

                  Container(
                    height: 150,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: sabores.length,
                      itemBuilder: (_, i)  {
                        bool isSelected = false;
                        for(var selectedItem in selected){
                          if(sabores[i] == selectedItem){
                            isSelected = true;
                          }
                        }
                        return Container(
                          padding: EdgeInsets.only(bottom:3),
                          child: ListTile(
                            leading: isSelected? Icon(Icons.check, color: Colors.red,) :Icon(Icons.square_outlined, color: Colors.red,),
                            title: Text("${sabores[i].sabor}", style: TextStyle(fontSize: 16)),
                            onTap: (){
                              if(isSelected){
                                setState((){
                                  selected.remove(sabores[i]);
                                });
                              }else{
                                setState(() {
                                  selected.add(sabores[i]);
                                });
                              }

                              
                            },
                          )
                        );
                      }
                    ),
                  ),
                  
                  
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Confirmar",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    onTap: (){
                      if(selected.isNotEmpty){
                        final ordersBloc = Provider.of<OrdersBloc>(context, listen: false);
                        Order order = Order(cantidad: 1, mercaderiaId: product.mercaderiaId,subTotal: product.precio1, descripcion: product.descripcion, sabores: selected );
                        ordersBloc.add(OnAddOrderToCart(order));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
            },
          );
        });
  }

  _buildProductsList(){
  return  BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsInitial) {
              return _buildLoading();
            } else if (state is ProductsLoading) {
              return _buildLoading();
            } else if (state is ProductsLoaded) {
              return _buildCard(context, state.products);
            } else if (state is ProductsError) {
              return Container();
            } else {
              return Container();
            }
      },
    );
  }
  _buildCard(BuildContext context, List<Product> prs) {
     List products = [];
      prs.where((element) => element.grupoId.toString() != widget.groupId); 

      for(var product in prs){
        if(product.grupoId.toString() == widget.groupId){
          products.add(product);
        }
      }
    // products.removeWhere((element) => element.grupoId.toString() != widget.groupId); 
 return (prs.isNotEmpty)?  Container(
        padding: const EdgeInsets.all(15),
        color: Colors.red,
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing:10,
          mainAxisSpacing: 10,
          childAspectRatio: (1 / 0.3),
          
          children: List.generate(products.length, (i) {  
            Product product = products[i];
            return ItemWidget(product: product, name: product.descripcion.cutString(), function: ()
              {

                  List<Sabor> sabores = _getSabores(product.mercaderiaId);
                  if(sabores.isEmpty){
                    final ordersBloc = Provider.of<OrdersBloc>(context, listen: false);
                    Order order = Order(cantidad: 1, mercaderiaId:product.mercaderiaId,subTotal: product.precio1, descripcion: product.descripcion, sabores: sabores );
                    ordersBloc.add(OnAddOrderToCart(order));
                  }else{
                    openAlertBox(sabores, product);
                  }

                  
                
                
              }
            );
          })
        ),
      ) : Container();
}
String cutString(String text) {
    String descripcion = "";
    if(text.length > 19){
      descripcion = "${text.substring(0, 19)}...";
    }else{
      descripcion = text;
    }
    return descripcion;
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
  
  List<Sabor> _getSabores(int mercaderiaId) {
    List<Sabor> sabores = [];
    List<MercaderiaSabor> mercaderiaSabores = [];

    final mercaderiaSaboresState = Provider.of<MercaderiasaboresBloc>(context, listen: false).state;
    final saboresState = Provider.of<SaboresBloc>(context, listen: false).state;

    if((mercaderiaSaboresState is MercaderiaSaboresLoaded) && (saboresState is SaboresLoaded)){
      for(var _mercaderiaSabor in mercaderiaSaboresState.mercaderiasabores){
        if(_mercaderiaSabor.mercaderiaId == mercaderiaId){
          mercaderiaSabores.add(_mercaderiaSabor);
        }
      }

      for(var sabor in saboresState.sabores){
        for(var mercaderiaSabor in mercaderiaSabores){
          if(sabor.saborid == mercaderiaSabor.saborId){
            sabores.add(sabor);
          }
        }
      }
    }
   

    return sabores;
  }



  
}

