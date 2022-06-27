

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> mostrarAlerta( BuildContext context, String titulo, String subtitulo)async {
  bool imprimir = false;
  if(Platform.isAndroid){
    
    await showDialog(
      context: context, 
      builder: ( _ ) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
        titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black87),
        title: Text( titulo ),
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: Colors.red,
            onPressed: () {
              Navigator.pop(context);
              setState((){
                imprimir = true;
              });
            },
            child: const Text('Si')
          ),

          MaterialButton(
            elevation: 5,
            textColor: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No')
          )
        ], 
      );
        },
      ),
    );

    return imprimir;
  } 

  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
    
      title: Text( titulo , style: const TextStyle(fontSize: 18, color: Colors.black87),),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            imprimir = true;
            Navigator.pop(context);
          },
          child: const Text('Si'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        )
      ],
    )
  );
  return imprimir;
  

}