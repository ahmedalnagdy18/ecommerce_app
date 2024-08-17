import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/features/home/domain/usecase/search_usecase.dart';
import 'package:flutter_application_test/injection_container.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_application_test/features/home/presentation/screens/card_details.dart';
import 'package:flutter_application_test/features/home/presentation/search/screens/search_page.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/accommodation_type.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/ads_banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(ProductUsecase(repository: sl()),
          SearchProductsUsecase(repository: sl()))
        ..fetchData(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_pageController.page == 3) {
          _pageController.animateToPage(
            _pageController.initialPage,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
          );
        }
        setState(() {
          _currentPaga = _pageController.page?.toInt() ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _currentPaga = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PostsLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Text(
                            'Welcome Back !',
                            style: TextAppTheme.mainBoldText,
                          )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text('Discover your property',
                            style: TextAppTheme.mainGreyBoldText),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (cont) => BlocProvider.value(
                                    value: context.read<PostsCubit>(),
                                    child: const SearchPage())));
                          },
                          child: const TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: 'Search for product',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      //  Accommodation Type

                      const AccommodationTypeWidget(),
                      const SizedBox(height: 30),

                      //  Recommended For You
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text('Recommended For You',
                            style: TextAppTheme.simiBoldText),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.posts.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          itemBuilder: (context, index) {
                            final cardData = state.posts[index];
                            return Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade300,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CardDetails(
                                        cardInfoEntity: cardData,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  cardData.images?[0] ?? '',
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CupertinoActivityIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      //! ads banner
                      AdsBannerWidget(
                        controller: _pageController,
                        onPageChanged: (v) {
                          setState(() {
                            _currentPaga = v;
                          });
                        },
                        position: _currentPaga,
                      ),
                    ],
                  ),
                ),
              ),
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
      },
    );
  }
}
