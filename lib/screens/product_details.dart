import 'package:ecogo/provider/home_provider.dart';
import 'package:ecogo/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({required this.id, Key? key}) : super(key: key);
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<HomeProvider>().getData(context, id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image: NetworkImage(snapshot.data!["image"])),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            snapshot.data!["title"],
                            style: Constants.textStyle,
                          )),
                          const Spacer(),
                          Text(
                            '₹${snapshot.data!["price"]}',
                            style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(snapshot.data!["description"]),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Category: ${snapshot.data!["category"]}',
                            style: const TextStyle(color: Colors.grey, fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Text(
                        'Rating: ${snapshot.data!["rating"]["rate"]} of ${snapshot.data!["rating"]["count"]}',
                        style: const TextStyle(color: Colors.orange, fontSize: 18),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(snapshot.error.toString())));
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }),
    );
  }
}
