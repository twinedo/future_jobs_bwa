import 'package:flutter/material.dart';
import 'package:future_jobs/models/category_model.dart';
import 'package:future_jobs/models/job_model.dart';
import 'package:future_jobs/providers/category_provider.dart';
import 'package:future_jobs/providers/job_provider.dart';
import 'package:future_jobs/providers/user_provider.dart';
import 'package:future_jobs/theme.dart';
import 'package:future_jobs/widgets/category_card.dart';
import 'package:future_jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var categoryProvider = Provider.of<CategoryProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Howdy',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      userProvider.user.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 58,
                  height: 58,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor,
                    ),
                  ),
                  child: Image.asset(
                    'assets/image_profile.png',
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget hotCategories() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Text(
              'Hot Categories',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 200,
            child: FutureBuilder<List<CategoryModel>>(
                future: categoryProvider.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    int index = -1;
                    return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data.map((e) {
                          index++;
                          return Container(
                            margin: EdgeInsets.only(
                              left: index == 0 ? defaultMargin : 0,
                            ),
                            child: CategoryCard(
                                // imageUrl: e.imageUrl, name: e.name
                                e),
                          );
                        }).toList()
                        // children: [
                        //   SizedBox(
                        //     width: defaultMargin,
                        //   ),
                        //   CategoryCard(
                        //     imageUrl: 'assets/image_category1.png',
                        //     name: 'Web Developer',
                        //   ),
                        //   CategoryCard(
                        //     imageUrl: 'assets/image_category2.png',
                        //     name: 'Mobile Developer',
                        //   ),
                        //   CategoryCard(
                        //     imageUrl: 'assets/image_category3.png',
                        //     name: 'App Designer',
                        //   ),
                        //   CategoryCard(
                        //     imageUrl: 'assets/image_category4.png',
                        //     name: 'Content Writer',
                        //   ),
                        //   CategoryCard(
                        //     imageUrl: 'assets/image_category5.png',
                        //     name: 'Video Grapher',
                        //   ),
                        // ],
                        );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      );
    }

    Widget justPosted() {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Just Posted',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<JobModel>>(
              future: jobProvider.getJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                      children: snapshot.data
                          .map((e) => JobTile(
                                // companyLogo: e.companyLogo,
                                // name: e.name,
                                // companyName: e.companyName,
                                e
                              ))
                          .toList());
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
            // JobTile(
            //   companyLogo: 'assets/icon_google.png',
            //   name: 'Front-End Developer',
            //   companyName: 'Google',
            // ),
            // JobTile(
            //   companyLogo: 'assets/icon_instagram.png',
            //   name: 'UI Designer',
            //   companyName: 'Instagram',
            // ),
            // JobTile(
            //   companyLogo: 'assets/icon_facebook.png',
            //   name: 'Data Scientist',
            //   companyName: 'Facebook',
            // ),
          ],
        ),
      );
    }

    Widget body() {
      return ListView(
        children: [
          header(),
          hotCategories(),
          justPosted(),
        ],
      );
    }

    Widget bottomNavBar() {
      return BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_home.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_notification.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_love.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_user.png',
              width: 24,
            ),
            label: '',
          ),
        ],
      );
    }

    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: body(),
    );
  }
}
