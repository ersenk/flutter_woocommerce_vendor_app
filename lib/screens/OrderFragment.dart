import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../component/OrderCardWidget.dart';
import '../main.dart';
import '../models/OrderResponse.dart';
import '../network/rest_apis.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstants.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderFragment extends StatefulWidget {
  static String tag = '/OrderFragment';

  @override
  _OrderFragmentState createState() => _OrderFragmentState();
}

class _OrderFragmentState extends State<OrderFragment> {
  bool mIsLastPage = false;
  int page = 1;
  List<OrderResponse> mOrderList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
     setStatusBarColor(primaryColor,statusBarIconBrightness: Brightness.light);
    super.initState();
    
    init();
    scrollController.addListener(() {
      if ((scrollController.position.pixels - 100) == (scrollController.position.maxScrollExtent - 100)) {
        if (!mIsLastPage) {
          page++;

          getOrder();
        }
      }
    });
  }

  init() async {
    getOrder();
  }

  Future<void> getOrder() async {
    appStore.setLoading(true);

    await getOrders(page).then((res) {
      if (page == 1) mOrderList.clear();
      mOrderList.addAll(res);
      mIsLastPage = res.length != perPage;
      setState(() {});
    }).catchError((e) {
      log(e.toString());
      toast(e.toString());
    });

    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.scaffoldBackground,
      appBar: appBarWidget(
        "",
        titleWidget: Text("${"lbl_orders".translate} (${mOrderList.length})", style: boldTextStyle(color: white)),
        elevation: 0,
        color: primaryColor,
        showBack: false,
        center: true,
      ),
      body: Stack(
        children: [
          mOrderList.isNotEmpty
              ? ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,padding: EdgeInsets.only(top: 16),
                  itemCount: mOrderList.length,
                  itemBuilder: (context, i) {
                    log(mOrderList[i].id);
                    return OrderCardWidget(
                      orderResponse:mOrderList[i],
                      onUpdate: () {
                        mOrderList.clear();
                        init();
                      },
                    );
                  }, separatorBuilder: (BuildContext context, int index) { return Divider(); },)
              : NoDataFound(
                  title: 'lbl_no_data'.translate,
                  onPressed: () {
                    getOrder();
                  },
                ).center().visible(!appStore.isLoading && mOrderList.isEmpty),
          6.height,
          Observer(builder: (_) => loading().center().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
