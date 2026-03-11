import 'package:ecommerceappapi/features/carts/presentation/cart_bloc/cart_bloc.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetAllCartList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartStatus == CartStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.cartStatus == CartStatus.loaded) {
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final cart = state.cart[index];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cart #${cart.id}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Loop through products
                        ...cart.products.map(
                          (product) => InkWell(
                            onTap: () {
                              // Navigate to ProductDetail for this product
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ProductDetail(id: product.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Image.network(
                                    product.thumbnail,
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text("\$${product.price.toStringAsFixed(2)}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state.cartStatus == CartStatus.failure) {
            return Center(child: Text(state.msz ?? "Error"));
          }

          return SizedBox();
        },
      ),
    );
  }
}
