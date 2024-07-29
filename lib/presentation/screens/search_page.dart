import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_application_test/presentation/screens/card_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context
                      .read<PostsCubit>()
                      .searchFuc(query: _searchController.text);
                },
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for agency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<PostsCubit, HomeState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is SearchLoaded) {
                      if (state.products.isEmpty) {
                        return const Center(
                          child: Text('No results found'),
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.products.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final post = state.products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CardDetails(
                                      imageUrl: post.images?[0] ?? '',
                                      price: post.price ?? 0.0,
                                      title: post.title ?? '',
                                      description: post.description ?? '',
                                      discountPercentage:
                                          post.discountPercentage ?? 0.0,
                                      category: post.category ?? '',
                                      brand: post.brand ?? '',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(minWidth: 100),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blueGrey),
                                      child: Image.network(
                                        post.images?[0] ?? '',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CupertinoActivityIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MainTextWidget(
                                            text: post.title ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          MainTextWidget(
                                            text: post.category ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MainTextWidget(
                                                text: '\$ ${post.price ?? 0.0}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '\$ -${post.discountPercentage ?? 0.0}',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
