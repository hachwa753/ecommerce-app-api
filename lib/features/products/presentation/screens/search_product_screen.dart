import 'package:ecommerceappapi/core/utils/debouncer.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/product_detail.dart';
import 'package:ecommerceappapi/features/products/presentation/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final debouncer = Debouncer(milliseconds: 500);
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            final query = value.trim();
            debouncer.run(() {
              if (query.isEmpty) {
                context.read<SearchBloc>().add(ClearEvent());
              } else {
                context.read<SearchBloc>().add(FetchProductsByQuery(query));
              }
            });
          },
          controller: searchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                context.read<SearchBloc>().add(
                  FetchProductsByQuery(searchController.text.trim()),
                );
              },
              icon: Icon(Icons.search),
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey.shade700),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.searchStatus == SearchStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.searchStatus == SearchStatus.loaded) {
            if (state.product.isEmpty) {
              return Center(child: Text("No products found"));
            }
            return ListView.builder(
              itemCount: state.product.length,

              itemBuilder: (context, index) {
                final product = state.product[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(id: product.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              product.thumbnail,
                              height: 80,
                              width: 80,
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                product.title,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
