import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/domain/usecase/usecase.dart';
import 'package:flutter_application_test/injection_container.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_application_test/presentation/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_test/presentation/screens/card_details.dart';
import 'package:flutter_application_test/presentation/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        Usecase(repository: sl()),
      )..fetchData(),
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
  int selecteditem = -1;
  int selectedindex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  void _onItemTapped(int value) {
    setState(() {
      selectedindex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == 3) {
        _pageController.animateToPage(
          _pageController.initialPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      } else {
        setState(() {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
          );
        });
      }
      _currentPaga = _pageController.page?.toInt() ?? 1;
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
            bottomNavigationBar: BottomNavigationBarWidget(
              currentIndex: selectedindex,
              onTap: _onItemTapped,
            ),
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          'Welcome Back !',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          'Discover your property',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for agency',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          'Accommodation Type',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selecteditem = index;
                                });
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  border: selecteditem == index
                                      ? Border.all(
                                          color: Colors.yellow.shade700,
                                          width: 3,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.blueGrey,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          'Recommended For You',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
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
                                color: Colors.blueGrey,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CardDetails(
                                        imageUrl: cardData.images?[0] ?? '',
                                        price: cardData.price ?? 0.0,
                                        title: cardData.title ?? '',
                                        description: cardData.description ?? '',
                                        discountPercentage:
                                            cardData.discountPercentage ?? 0.0,
                                        category: cardData.category ?? '',
                                        brand: cardData.brand ?? '',
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
                                        color: Colors.white,
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
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: 4,
                          onPageChanged: (v) {
                            setState(() {
                              _currentPaga = v;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: DotsIndicator(
                          dotsCount: 4,
                          position: _currentPaga,
                          decorator: DotsDecorator(
                            size: const Size.square(10),
                            activeSize: const Size(24, 9),
                            activeShape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                            activeColor: Colors.white,
                            color: Colors.black,
                            spacing: const EdgeInsets.all(3),
                          ),
                        ),
                      )
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
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
