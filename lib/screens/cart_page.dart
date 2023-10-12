import 'package:ecogo/provider/home_provider.dart';
import 'package:ecogo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = context.read<HomeProvider>().cart;
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            'Cart',
            style: Constants.textStyle,
          ),
          centerTitle: true,
        ),
        body: data.isEmpty
            ? const Center(child: Text('Cart is Empty'))
            : ListView.separated(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.white38.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: ClipOval(
                            child: Image.network(
                          data[index].image,
                          width: 70,
                          height: 90,
                          fit: BoxFit.fill,
                        )),
                        trailing: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data[index].title),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Price: ₹${data[index].price.toString()}',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ));
  }
}
