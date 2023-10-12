import 'package:ecogo/provider/home_provider.dart';
import 'package:ecogo/screens/cart_page.dart';
import 'package:ecogo/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  List images = [
    'https://as2.ftcdn.net/v2/jpg/02/72/04/33/1000_F_272043321_ZgcwrsgCvqe4irLOs3mZ9ze9qGAs6QkW.jpg',
    'https://static.vecteezy.com/system/resources/previews/003/418/147/non_2x/girl-in-a-red-dress-sketch-fashion-illustration-vector.jpg',
    'https://st3.depositphotos.com/4481235/34821/i/450/depositphotos_348215620-stock-illustration-pencil-drawing-necklace-ring-precious.jpg',
    'https://img.freepik.com/premium-vector/shoes-sneaker-footwear-vector-image-illustration_776624-108.jpg',
    'https://media.istockphoto.com/id/1143213808/vector/processor-or-electronic-chip-on-circuit-board-with-conductive-tracks-and-soft-realistic.jpg?s=612x612&w=0&k=20&c=xDDc74Pjk7vtuc156GWu353q_hNmWXoPJ3110QNY-BY='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
              future: context.read<HomeProvider>().getApi(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Material(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: TextField(
                          decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.search, color: Constants.gColor),
                              hintStyle: TextStyle(color: Constants.gColor),
                              hintText: 'Search',
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Categories',
                        style: Constants.textStyle,
                      ),
                      SizedBox(
                        height: 70,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Image(
                                width: 70,
                                image: NetworkImage(images[index]),
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: images.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Popular Products',
                        style: Constants.textStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 3 / 4),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                              id: snapshot.data![index].id
                                                  .toString(),
                                            )));
                              },
                              child: Card(
                                elevation: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data![index].image!),
                                                fit: BoxFit.fill)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data![index].title!,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '₹${snapshot.data![index].price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(5, (index1) {
                                            return Icon(
                                              index1 <
                                                      snapshot.data![index]
                                                          .rating!.rate
                                                          .round()
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.orange,
                                            );
                                          })),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<HomeProvider>().cartData(
                                              snapshot.data![index], context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black),
                                        child: const Text('add to cart'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ]),
                  );
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snapshot.error.toString())));
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              })),
    );
  }
}
