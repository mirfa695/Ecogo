import 'package:ecogo/model_class/class_products.dart';
import 'package:ecogo/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        elevation: 2,
        leading: Icon(Icons.menu,color: Colors.black,),actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart,color: Colors.black,))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation: 10,
                shadowColor: Colors.black,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search,color:Constants.gColor),
                      hintStyle: TextStyle(color: Constants.gColor),
                      hintText: 'Search',enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              SizedBox(height: 10,),
              Text('Categories',style: Constants.textStyle,),
              Container(height: 50,
              child: ListView.separated(scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,int index){
                return const Card(
                  child: Image(image: NetworkImage('https://as2.ftcdn.net/v2/jpg/02/72/04/33/1000_F_272043321_ZgcwrsgCvqe4irLOs3mZ9ze9qGAs6QkW.jpg'),fit: BoxFit.fill,),
                );
              }, separatorBuilder: (BuildContext context, int index) { 
                return SizedBox(width: 5,);
              }, itemCount: 5,),),
              SizedBox(height: 10,),
              Text('Popular Products',style: Constants.textStyle,),
              SizedBox(height: 10,),
              Container(
                height: 2000,
                child: FutureBuilder<List<Product>>(future:context.read<HomeProvider>().getApi(context), builder: (context,snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                      physics:NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,

                        ),
                        itemBuilder: (context,index){
                          return Card(
                            elevation: 20,
                            child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Container(
                                height:50,width: 50,
                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data![index].image!),fit: BoxFit.fill)),
                              ),
                              Flexible(child: Text(snapshot.data![index].title!))
                            ],
                          ),);
                        });
                  }else{
                   return Text('error');
                  }throw 'Error';
                }           ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
