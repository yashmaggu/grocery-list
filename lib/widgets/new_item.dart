import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/data/categories.dart';
import 'package:grocery/models/category_1.dart';
import 'package:grocery/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var enteredName = "";
  int eneteredQuantity = 0;
  var selectedCategory = categories[Categories.vegetables]!;

  void _saveitem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final url = Uri.https(
        'https://groceries-a2193-default-rtdb.firebaseio.com/',
        'Groceries.json',
      );
      http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'name':enteredName,
            'quantity':eneteredQuantity,
            'category':selectedCategory.title,
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 70,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length == 1 ||
                      value.trim().length > 50) {
                    return 'Errror Message(lenght of characters MUST BE BETWEEN 1 TO 50)';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredName = value!.toString();
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        label: Text('quantity'),
                      ),
                      initialValue: '0',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        eneteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title),
                              ]),
                            )
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        }),
                  )
                ],
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _formkey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: _saveitem, child: const Text('Add Item')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
