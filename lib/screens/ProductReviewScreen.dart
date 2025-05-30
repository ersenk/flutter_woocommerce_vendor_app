import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../component/ReviewItemWidget.dart';
import '../main.dart';
import '../models/ReviewResponse.dart';
import '../network/rest_apis.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstants.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductReviewScreen extends StatefulWidget {
  static String tag = '/ProductReviewScreen';

  @override
  ProductReviewScreenState createState() => ProductReviewScreenState();
}

class ProductReviewScreenState extends State<ProductReviewScreen> {
  int page = 1;
  bool mIsLastPage = false;
  List<ReviewResponse> reviewList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(Duration(milliseconds: 2));
    getAllProductReviewList();

    scrollController.addListener(() {
      if ((scrollController.position.pixels - 100) == (scrollController.position.maxScrollExtent - 100)) {
        if (!mIsLastPage) {
          page++;
          appStore.setLoading(true);
          getAllProductReviewList();
          setState(() {});
        }
      }
    });
  }

  Future<void> getAllProductReviewList() async {
    appStore.setLoading(true);

    await getAllReview(page: page).then((res) async {
      if (page == 1) reviewList.clear();

      reviewList.addAll(res);
      mIsLastPage = res.length != perPage;
      setState(() {});
    }).catchError((e) {
      log(e.toString());
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    LiveStream().dispose(REMOVE_REVIEW);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("lbl_Product_Review".translate, color: primaryColor, textColor: Colors.white),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            if (reviewList.isNotEmpty)
              ListView.separated(
                controller: scrollController,
                itemCount: reviewList.length,
                itemBuilder: (context, i) {
                  ReviewResponse review = reviewList[i];
                  return ReviewItemWidget(
                    data: review,
                    onUpdate: () {
                      setState(() {});
                    },
                    onDelete: (id) {
                      reviewList.removeWhere((element) => element.id == id);
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 0);
                },
              ),
            NoDataFound(
              title: 'no_review_available'.translate,
              onPressed: () {
                finish(context);
              },
            ).visible(!appStore.isLoading && reviewList.isEmpty),
            Observer(builder: (_) => loading().visible(appStore.isLoading))
          ],
        ),
      ),
    );
  }
}
