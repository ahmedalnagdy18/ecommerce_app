import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_application_test/features/home/presentation/search/widgets/search_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  void _searchOnChange(String value) {
    context.read<PostsCubit>().searchFuc(query: value);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                onChanged: (value) => _searchOnChange(value),
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
                        final postState = state.products;
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          physics: const BouncingScrollPhysics(),
                          itemCount: postState.length,
                          cacheExtent: postState.length.toDouble(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return SearchItem(post: postState[index]);
                          },
                        );
                      }
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return const SizedBox.shrink();
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
