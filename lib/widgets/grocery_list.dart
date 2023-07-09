 


import 'package:flutter/material.dart';
import 'package:grocery/models/grocery_item.dart';
import 'package:grocery/widgets/new_item.dart';

class GroceryList extends StatefulWidget{
const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

final List<Groceries> _groceryItems=[];
void _addItem() async{
final newItem1= await Navigator.of(context).push<Groceries>(
  MaterialPageRoute(builder: (ctx)=>const NewItem())
);
if(newItem1==null) return;
setState(() {
  
_groceryItems.add(newItem1);
});
}

void removeTem(Groceries item){
  setState(() {
    _groceryItems.remove(item);
  });
}

@override
Widget build(BuildContext context)
{
  Widget content=const Center(child:Text('empty !!! enter the value by clicking on top right corner'));
  if(_groceryItems.isNotEmpty)
  {
   content= ListView.builder(
    itemCount:_groceryItems.length,
    itemBuilder: (ctx,index)=>
  Dismissible(
    onDismissed: (direction) {
      removeTem((_groceryItems[index]));
    },
    key: ValueKey(_groceryItems[index].id),
    child: ListTile(
      title:Text(_groceryItems[index].name),
    leading:Container(
     width:24,
    color: _groceryItems[index].category.color,
    ),
    trailing: Text(_groceryItems[index].quantity.toString()),
    ),
  ),  
  );
  }
  
  
  
  
  
  return Scaffold(
    appBar: AppBar(title: const Text('groceries List '),
    actions: [
      IconButton(onPressed: _addItem, icon: const Icon(Icons.abc_outlined))
    ],),
    body: content,
  );
}
}