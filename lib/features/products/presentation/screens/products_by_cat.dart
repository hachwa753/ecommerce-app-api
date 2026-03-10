import 'package:ecommerceappapi/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCat extends StatefulWidget {
  final String category;
  const ProductsByCat({super.key, required this.category});

  @override
  State<ProductsByCat> createState() => _ProductsByCatState();
}

class _ProductsByCatState extends State<ProductsByCat> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductsByCategories(widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.toLowerCase())),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.productStatus == ProductStatus.loaded) {
              return GridView.builder(
                itemCount: state.productbyCat.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = state.productbyCat[index];
                  return Container(
                    child: Column(
                      children: [
                        Image.network(product.thumbnail, height: 80),
                        Text(product.title),
                      ],
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
