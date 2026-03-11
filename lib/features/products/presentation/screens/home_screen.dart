import 'package:ecommerceappapi/features/products/presentation/category_bloc/category_bloc.dart';
import 'package:ecommerceappapi/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/product_detail.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/products_by_cat.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/search_product_screen.dart';
import 'package:ecommerceappapi/features/products/presentation/widgets/my_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchAllProducts());
    context.read<CategoryBloc>().add(FetchAllCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello bro!"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchProductScreen()),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.categoryStatus == CategoryStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.categoryStatus == CategoryStatus.loaded) {
                  return SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = state.category[index];
                        return MyListContainer(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductsByCat(category: category.slug),
                              ),
                            );
                          },
                          title: category.name,
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state.productStatus == ProductStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.productStatus == ProductStatus.loaded) {
                    // print(state.product.length);
                    return Stack(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          itemCount: state.product.length,
                          itemBuilder: (context, index) {
                            final product = state.product[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ProductDetail(id: product.id),
                                  ),
                                );
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.network(
                                      product.thumbnail,
                                      height: 100,
                                    ),
                                    Text(product.title),
                                    SizedBox(height: 8),
                                    // Align(
                                    //   alignment: Alignment.bottomLeft,
                                    //   child: Container(
                                    //     margin: EdgeInsets.only(right: 5),
                                    //     padding: EdgeInsets.symmetric(horizontal: 5),
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.grey.shade200,
                                    //     ),
                                    //     child: Text(product.tags.join(",")),
                                    //   ),
                                    // ),
                                    Wrap(
                                      spacing: 5,

                                      children:
                                          product.tags
                                              .map(
                                                (e) => Container(
                                                  // margin: EdgeInsets.only(right: 5),
                                                  color: Colors.grey.shade200,
                                                  child: Text(e),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
