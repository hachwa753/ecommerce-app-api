import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceappapi/core/utils/date_extension.dart';
import 'package:ecommerceappapi/features/carts/presentation/cart_bloc/cart_bloc.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';
import 'package:ecommerceappapi/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product? selectedProduct;
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductDetail(widget.id));
    super.initState();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id.toString())),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.detailProductStatus == DetailProductStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.detailProductStatus == DetailProductStatus.loaded) {
            if (state.product.isEmpty) {
              return Center(child: Text("No Product Found"));
            }
            selectedProduct = state.selectedProduct;
            final product = state.selectedProduct!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.images.length == 1
                        ? Image.network(product.images.first)
                        : CarouselSlider(
                          items:
                              product.images.map((image) {
                                return Builder(
                                  builder: (context) {
                                    return Image.network(image);
                                  },
                                );
                              }).toList(),
                          options: CarouselOptions(
                            height: 400,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                        ),

                    SizedBox(height: 15),
                    if (product.images.length > 1)
                      Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: currentIndex,
                          count: product.images.length,
                          effect: SwapEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Colors.blue,
                            dotColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(product.description, style: TextStyle(fontSize: 17)),
                    SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            maxLength: 200,

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 2,

                                  color: Colors.grey.shade400,
                                ),
                              ),
                              hintText: "Write comment",
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.send, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    product.reviews.isEmpty
                        ? Text("No Reviews yet")
                        : Column(
                          children:
                              product.reviews.map((review) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.date.toReadableDate(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      review.comment,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(review.reviewerName),
                                  ],
                                );
                              }).toList(),
                        ),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              final product = productState.selectedProduct;

              return BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  bool inCart = false;

                  if (product != null &&
                      cartState.cartStatus == CartStatus.loaded) {
                    // Check if product is already in cart
                    inCart = cartState.cart.any(
                      (cart) => cart.products.any((p) => p.id == product.id),
                    );
                  }

                  return ElevatedButton(
                    onPressed:
                        product == null || inCart
                            ? null // disable if product is null or already in cart
                            : () {
                              context.read<CartBloc>().add(
                                AddProductToCart(product),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${product.title} added to cart",
                                  ),
                                ),
                              );
                            },
                    child: Text(inCart ? "Already in Cart" : "Add To Cart"),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
