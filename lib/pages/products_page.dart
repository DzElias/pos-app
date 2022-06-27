import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/bloc/groups/groups_bloc.dart';
import 'package:pos_app/bloc/mercaderiaSabores/mercaderiasabores_bloc.dart';
import 'package:pos_app/bloc/products/products_bloc.dart';
import 'package:pos_app/bloc/sabores/sabores_bloc.dart';
import 'package:pos_app/models/grupo.dart';
import 'package:pos_app/pages/group_page.dart';
import 'package:pos_app/widgets/custom_page_route.dart';
import 'package:pos_app/widgets/icon_btn.dart';
import 'package:pos_app/widgets/item_widget.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    
    _initialization();
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.redAccent,
        // iconTheme: const IconThemeData(color: Colors.white),
        // leading: const Icon(Icons.point_of_sale),
        title: Text("Productos", style: TextStyle(fontWeight: FontWeight.w500),),
        
      ),
      body: _buildGroupsList()
    );
  }
  
  void _initialization() {
    var groupsBloc = Provider.of<GroupsBloc>(context, listen: false);
    var productsBloc = Provider.of<ProductsBloc>(context, listen: false);
    var saboresBloc = Provider.of<SaboresBloc>(context, listen: false);
    var mercaderiasaboresBloc = Provider.of<MercaderiasaboresBloc>(context, listen: false);
    if(groupsBloc.state is! GroupLoaded){
      groupsBloc.add(GetGroupsList());
    
    
      productsBloc.add(GetProductsList());
    
    
      saboresBloc.add(GetSaboresList());
    
    
      mercaderiasaboresBloc.add(GetMercaderiaSaboresList());
    }
    
  }
}

_buildGroupsList(){
  return BlocListener<GroupsBloc, GroupsState>(
    listener: (context, state) {
      if (state is GroupError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message!),
          ),
        );
      }
    },
    
    child: BlocBuilder<GroupsBloc, GroupsState>(
      builder: (context, state) {
        if (state is GroupInitial) {
              return _buildLoading();
            } else if (state is GroupLoading) {
              return _buildLoading();
            } else if (state is GroupLoaded) {
              return _buildCard(context, state.groups);
            } else if (state is GroupError) {
              return Container();
            } else {
              return Container();
            }
      },
    )
  );
}

_buildCard(BuildContext context, List<Grupo> groups) {
  return groups.isNotEmpty ? Container(
        padding: const EdgeInsets.all(15),
        color: Colors.red,
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing:10,
          mainAxisSpacing: 10,
          childAspectRatio: (1 / 0.18),
          
          children: List.generate(groups.length, (i) {  
            String id = groups[i].grupoId.toString();
            return ItemWidget(name: groups[i].grupo, function: ()
              {
                final page = GroupPage(groupId: id, groupName: groups[i].grupo );
                Navigator.of(context).push(CustomRoute().createRoute(page));
              }
            );
          })
        ),
      ): Container();
}



Widget _buildLoading() => const Center(child: CircularProgressIndicator());




