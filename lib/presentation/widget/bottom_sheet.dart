import 'package:bloc_firebase_test/bloc/add_data_bloc/add_data_bloc.dart';
import 'package:bloc_firebase_test/bloc/bloc/fetch_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBottomNavigationSheet({
  required BuildContext context,
}) {
  final TextEditingController range = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController usage = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add data',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  child: TextField(
                    controller: range,
                    decoration: InputDecoration(suffixText: 'range in km'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextField(
                    controller: price,
                    decoration: InputDecoration(suffixText: 'price'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextField(
                    controller: usage,
                    decoration: InputDecoration(suffixText: 'usage l/100km'),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<AddDataBloc>().add(AddInformation(
                          usage: double.tryParse(usage.text),
                          price: double.tryParse(price.text),
                          range: double.tryParse(range.text)));
                      range.dispose();
                      price.dispose();
                      context.read<FetchDataBloc>().add(InitialFetchedData());
                      Navigator.of(context).pop();
                    },
                    child: Text('Update data'))
              ],
            ),
          ),
        );
      });
}
