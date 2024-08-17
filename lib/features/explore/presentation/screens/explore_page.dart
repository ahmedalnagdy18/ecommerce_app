import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter_application_test/features/explore/presentation/cubit/explore_state.dart';
import 'package:flutter_application_test/features/explore/presentation/widget/explore_item_body.dart';
import 'package:flutter_application_test/features/explore/presentation/widget/sale_animition_part.dart';
import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/features/home/presentation/screens/card_details.dart';
import 'package:flutter_application_test/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit(
        ProductUsecase(repository: sl()),
      )..getExploreData(),
      child: const _ExplorePage(),
    );
  }
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double containerHeight = queryData.size.height * 0.30;

    return BlocConsumer<ExploreCubit, ExploreState>(listener: (context, state) {
      if (state is ExplorePostsError) {
        Center(
          child: Text(state.message),
        );
      }
    }, builder: (context, state) {
      if (state is ExplorePostsLoaded) {
        final filteredPosts =
            state.posts.where((post) => post.price! > 300).toList();
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SaleAnimationWidget(
                    height: containerHeight, // sale animation part
                  )),
              Padding(
                padding: EdgeInsets.only(top: containerHeight),
                child: SingleChildScrollView(
                  child: BlocBuilder<ExploreCubit, ExploreState>(
                    builder: (context, state) {
                      if (state is ExplorePostsLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (state is ExplorePostsLoaded) {
                        if (state.posts.isEmpty) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        } else {
                          final postState = filteredPosts;
                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredPosts.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final post = postState[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CardDetails(
                                          cardInfoEntity: post,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ExploreItemBody(
                                    cardInfoEntity: post, //  =>  item body
                                  ));
                            },
                          );
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: CupertinoActivityIndicator(color: Colors.black),
          ),
        );
      }
    });
  }
}
