import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter_application_test/features/explore/presentation/cubit/explore_state.dart';
import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

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
                child: Container(
                  height: containerHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'Sale Up To',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Center(
                        child: WidgetAnimator(
                          atRestEffect: WidgetRestingEffects.swing(),
                          child: const Text(
                            '60 \$',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                              return Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Row(
                                  children: [
                                    Banner(
                                      location: BannerLocation.topStart,
                                      message: 'Sale',
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey.shade300),
                                        child: Image.network(
                                          post.images?[0] ?? '',
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
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
                              );
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
            child: CupertinoActivityIndicator(),
          ),
        );
      }
    });
  }
}
