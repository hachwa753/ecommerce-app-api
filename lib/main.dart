import 'package:ecommerceappapi/features/carts/data/datasource/cart_api_source.dart';
import 'package:ecommerceappapi/features/carts/data/repo/cart_repo_impl.dart';
import 'package:ecommerceappapi/features/carts/presentation/cart_bloc/cart_bloc.dart';
import 'package:ecommerceappapi/features/products/data/datasource/api_source.dart';
import 'package:ecommerceappapi/features/products/data/repo/product_repo_impl.dart';
import 'package:ecommerceappapi/features/products/presentation/category_bloc/category_bloc.dart';
import 'package:ecommerceappapi/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:ecommerceappapi/features/products/presentation/search_bloc/search_bloc.dart';
import 'package:ecommerceappapi/features/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(ProductRepoImpl(ApiSource())),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(ProductRepoImpl(ApiSource())),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductRepoImpl(ApiSource())),
        ),
        BlocProvider(
          create: (context) => CartBloc(CartRepoImpl(CartApiSource())),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: RootScreen()),
    );
  }
}
