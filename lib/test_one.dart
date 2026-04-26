import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestOne extends StatelessWidget {
  TestOne({super.key});
  String name = 'Fadhil';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Model>(
                builder: (context, model, child) {
                  print('Consumer is Called');
                  return Text("Hello, ${model.name}!");
                },
              ),
              SizedBox(height: 20),
              Consumer<Model>(
                builder: (context, model, child) {
                  print('Consumer 2 is Called');
                  return ElevatedButton(
                    onPressed: () {
                      model.changeName();
                    },
                    child: Text("Change Name"),
                  );
                },
              ),
              SizedBox(height: 40),

              Consumer<Model>(
                builder: (context, model, child) {
                  print('Consumer 3 is Called');
                  return Text("Consumer: ${model.name2}");
                },
              ),
              SizedBox(height: 20),
              Consumer<Model>(
                builder: (context, model, child) {
                  print('Consumer 4 is Called');
                  return ElevatedButton(
                    onPressed: () {
                      model.changeName2();
                    },
                    child: Text("Change Name 2"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Model extends ChangeNotifier {
  String name = 'Fadhil';
  String name2 = 'Ali';
  
  changeName() {
    name = 'abbas';
    notifyListeners();
  }

  changeName2() {
    name2 = 'Hussain';
    notifyListeners();
  }
}
