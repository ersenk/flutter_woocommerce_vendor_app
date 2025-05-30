import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:woocommerce_vendor_app/utils/AppColors.dart';
import '../component/OrderCardWidget.dart';
import '../main.dart';
import '../models/OrderResponse.dart';
import '../models/VendorModel.dart';
import '../network/rest_apis.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstants.dart';
import 'package:nb_utils/nb_utils.dart';

class VendorDashboardScreen extends StatefulWidget {
  @override
  _VendorDashboardScreenState createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
  setStatusBarColor(primaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(context.scaffoldBackgroundColor);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder<VendorModel>(
            future: getVendorDashboard(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerWidget(),
                        orderSummary(snap.data!.orderSummary),
                        Divider(height: 16),
                        orderWidget(snap.data!.order),
                      ],
                    ),
                  ),
                );
              }
              return snapWidgetHelper(snap);
            },
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Observer(builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        width: context.width(),
        decoration: boxDecorationWithShadow(backgroundColor: appStore.appBarColor!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat("MMMM dd, yyyy").format(DateTime.now()), style: secondaryTextStyle()),
            Text('${"lbl_Hello".translate}, ${getStringAsync(FIRST_NAME)} ${getStringAsync(LAST_NAME)}', style: boldTextStyle()),
          ],
        ),
      );
    });
  }

  Widget orderSummary(OrderSummary? orderSummary) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('lbl_order_total'.translate, style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
          16.height,
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              cardWidget1(context, total: orderSummary!.wcPending.validate(), orderName: "lbl_pending".translate),
              cardWidget1(context, total: orderSummary.wcProcessing.validate(), orderName: "lbl_processing".translate),
              cardWidget1(context, total: orderSummary.wcOnHold.validate(), orderName: "lbl_on_hold".translate),
              cardWidget1(context, total: orderSummary.wcCompleted.validate(), orderName: "lbl_completed".translate),
              cardWidget1(context, total: orderSummary.wcCancelled.validate(), orderName: "lbl_cancelled".translate),
              cardWidget1(context, total: orderSummary.wcRefunded.validate(), orderName: "lbl_Refunded".translate),
              cardWidget1(context, total: orderSummary.wcFailed.validate(), orderName: "lbl_failed".translate),
            ],
          )
        ],
      ),
    );
  }

  Widget orderWidget(List<OrderResponse>? order) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('lbl_new_order'.translate, style: boldTextStyle(size: 18)).paddingSymmetric(horizontal: 16),
          ListView.separated(
            separatorBuilder: (context, i) => Divider(height: 0),
            itemCount: order!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              OrderResponse data = order[i];
              return OrderCardWidget(orderResponse: data);
            },
          )
        ],
      ),
    );
  }
}
