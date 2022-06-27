import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pos_app/bloc/products/products_bloc.dart';
import 'package:pos_app/models/order.dart';
import 'package:pos_app/services/api_repository.dart';
import 'package:pos_app/widgets/item_widget.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // ignore: empty_constructor_bodies
  OrdersBloc() : super(OrdersState()) {
    on<OnAddOrderToCart>((event, emit) {
      var orders = state.orders;
      int i = orders.indexWhere(
          (element) => element.mercaderiaId == event.order.mercaderiaId);
      Fluttertoast.showToast(
          msg: "Se añadio correctamente",
          textColor: Colors.white,
          backgroundColor: Colors.green);
      if (i < 0) {
        emit(state.copyWith(orders: [event.order, ...state.orders]));
      } else {
        add(OnAddAmount(event.order.mercaderiaId));
      }
    });

    on<OnRemoveOrder>((event, emit) {
      List<Order> orders = state.orders;
      orders
          .removeWhere((element) => element.mercaderiaId == event.mercaderiaId);
      emit(state.copyWith(orders: orders));
      var aux = state;
      emit(OrderRemoved());
      emit(aux);
    });

    on<OnAddAmount>((event, emit) {
      List<Order> orders = state.orders;
      int i = orders
          .indexWhere((element) => element.mercaderiaId == event.mercaderiaId);

      orders[i].cantidad = orders[i].cantidad + 1;
      emit(state.copyWith(orders: orders));
      var aux = state;
      emit(OrderRemoved());
      emit(aux);
    });

    on<OnSubAmount>((event, emit) {
      List<Order> orders = state.orders;
      int i = orders.indexWhere((element) => element.mercaderiaId == event.mercaderiaId);

      if (orders[i].cantidad > 1) {
        orders[i].cantidad = orders[i].cantidad - 1;
        emit(state.copyWith(orders: orders));
        var aux = state;
        emit(OrderRemoved());
        emit(aux);
      } else {
        add(OnRemoveOrder(event.mercaderiaId));
      }
    });
  }
  final ApiRepository _apiRepository = ApiRepository();

  sendOrder(bool value) async{
    List<Order> orders = state.orders;
    List ordersJSON = [];
    if(value) await printOrders(orders);

    for (var singleOrder in orders) {
      ordersJSON.add(singleOrder.toJson());
    }

    _apiRepository.postOrders(ordersJSON);
    Fluttertoast.showToast(msg: "Se envio correctamente",textColor: Colors.white,backgroundColor: Colors.green);
    emit(state.copyWith(orders: []));
    var aux = state;
    emit(OrderRemoved());
    emit(aux);
  }

  Future<void> printOrders(List<Order> orders) async {
    _bindingPrinter().then((bool? isBind) async => {
          if (isBind!)await printCart(orders)
    });
  }

  printCart(List<Order> orders) async {

            int total = 0;
    
            await SunmiPrinter.initPrinter();

            await SunmiPrinter.startTransactionPrint(true);
            await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.line();
            await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.bold();
            await SunmiPrinter.printText('Mi Abuela');
            await SunmiPrinter.resetBold();
            await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.printText('Area 2');
             await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.printText('CDE');
             await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.printText('061 509 178 - 098 362 686');
            await SunmiPrinter.line();
            await SunmiPrinter.printRow(cols: [
              ColumnMaker(
                  text: 'Nombre', width: 12, align: SunmiPrintAlign.LEFT),
              ColumnMaker(
                  text: 'Cant', width: 6, align: SunmiPrintAlign.CENTER),
              ColumnMaker(text: 'Unid', width: 6, align: SunmiPrintAlign.RIGHT),
              ColumnMaker(
                  text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
            ]);

            
            for(Order order in orders ){
              await SunmiPrinter.printRow(cols: [
                ColumnMaker(
                  text: cutString(order.descripcion.capitalize()), width: 12, align: SunmiPrintAlign.LEFT),
                ColumnMaker(
                  text: order.cantidad.toString(), width: 6, align: SunmiPrintAlign.CENTER),
                ColumnMaker(
                  text: order.subTotal.toString(), width: 6, align: SunmiPrintAlign.RIGHT),
                ColumnMaker(
                  text: (order.cantidad * order.subTotal).toString(), width: 6, align: SunmiPrintAlign.RIGHT),
                ]);
                if(order.sabores.isNotEmpty){
                  
                  if(order.sabores.length == 2)
                  {
                    await SunmiPrinter.printRow(cols: [

                      ColumnMaker(text: cutString(order.sabores[0].sabor.capitalize()), width: 12, align: SunmiPrintAlign.LEFT),
                      ColumnMaker(text: cutString(order.sabores[1].sabor.capitalize()), width: 12, align: SunmiPrintAlign.CENTER),
                    ]);
                  }
                  else{
                    await SunmiPrinter.printRow(cols: [

                      ColumnMaker(text: cutString(order.sabores[0].sabor.capitalize()), width: 12, align: SunmiPrintAlign.LEFT)

                    ]);
                  }
                }
                total = total + (order.cantidad * order.subTotal);
            }
            
            await SunmiPrinter.line();
            await SunmiPrinter.printRow(cols: [
              ColumnMaker(
                  text: 'TOTAL', width: 20, align: SunmiPrintAlign.LEFT),
              ColumnMaker(
                  text: "${total.toString()} Gs", width: 9, align: SunmiPrintAlign.RIGHT),
            ]);
            await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.line();
            await SunmiPrinter.bold();
            await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
            await SunmiPrinter.printText('*Gracias por su compra*');
            await SunmiPrinter.resetBold();
            // await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer');
            await SunmiPrinter.lineWrap(2);
            await SunmiPrinter.exitTransactionPrint();
            return;
          
    
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }
  
  cutString(String text) {
    String descripcion = "";
    if(text.length > 12){
      descripcion = "${text.substring(0, 11)}-";
    }else{
      descripcion = text;
    }
    return descripcion;
  }
}
