import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/cart.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form validated');
    } else {
      print('Form not validated');
      return;
    }
  }

  late List<List<String>> items = [];
  late String title;
  late String description;
  bool? _isFirstItemSelected = false;
  bool? _isSecondItemSelected = false;
  bool? _isThirdItemSelected = false;
  bool? _isFourthItemSelected = false;
  String titleItem1 = "Nasi Goreng";
  String titleItem2 = "Mie rebus";
  String titleItem3 = "Nasi Sarden";
  String titleItem4 = "Nasi Urak-Arik";
  String descItem1 = "Rp12.000";
  String descItem2 = "Rp8.000";
  String descItem3 = "Rp10.000";
  String descItem4 = "Rp9.000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Keranjang'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheckboxListTile(
                  title: Text(titleItem1),
                  subtitle: Text(descItem1),
                  value: _isFirstItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFirstItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(titleItem2),
                  subtitle: Text(descItem2),
                  value: _isSecondItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSecondItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(titleItem3),
                  subtitle: Text(descItem3),
                  value: _isThirdItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isThirdItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(titleItem4),
                  subtitle: Text(descItem4),
                  value: _isFourthItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFourthItemSelected = value;
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          validated();
                        },
                        child: const Text('Tambah ke Keranjang'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Item> todobox = Hive.box<Item>('items');
    if (_isFirstItemSelected == true) {
      items.add([titleItem1, descItem1]);
      _isFirstItemSelected = false;
    }
    if (_isSecondItemSelected == true) {
      items.add([titleItem2, descItem2]);
      _isSecondItemSelected = false;
    }
    if (_isThirdItemSelected == true) {
      items.add([titleItem2, descItem2]);
      _isThirdItemSelected = false;
    }
    if (_isFourthItemSelected == true) {
      items.add([titleItem2, descItem2]);
      _isFourthItemSelected = false;
    }
    items.forEach((item) {
      todobox.add(Item(title: item[0], description: item[1]));
    });
    SnackBar snackBar = const SnackBar(content: Text("Ditambahkan ke Keranjang"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(todobox);
  }
}
