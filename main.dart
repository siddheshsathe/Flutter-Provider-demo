import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'data.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => Items())],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();

  Widget modalContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              label: Text("Name"),
            ),
            keyboardType: TextInputType.name,
          ),
          TextField(
            controller: idCtrl,
            decoration: const InputDecoration(
              label: Text("ID"),
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: priceCtrl,
            decoration: const InputDecoration(
              label: Text("Price"),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty &&
                    idCtrl.text.isNotEmpty &&
                    priceCtrl.text.isNotEmpty) {
                  context.read<Items>().addItem(
                      nameCtrl.text, idCtrl.text, int.parse(priceCtrl.text));
                  Navigator.of(context).pop();
                  nameCtrl.text = "";
                  idCtrl.text = "";
                  priceCtrl.text = "";
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Entry"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider demo"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return modalContainer(context);
                },
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: context.watch<Items>().itemList.length,
        itemBuilder: (ctx, index) {
          var itemInfo = context.watch<Items>().itemList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text("${itemInfo.price}"),
            ),
            title: Text(itemInfo.name),
            subtitle: Text(itemInfo.id),
          );
        },
      ),
    );
  }
}
