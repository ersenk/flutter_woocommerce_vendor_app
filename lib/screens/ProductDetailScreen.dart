import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../main.dart';
import '../models/ProductDetailResponse.dart';
import '../network/rest_apis.dart';
import '../screens/AddProductScreen.dart';
import '../screens/ZoomImageScreen.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? mProId;

  ProductDetailScreen({Key? key, this.mProId}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool mIsGroupedProduct = false;

  String? mSelectedVariation = '';
  num rating = 0;
  num discount = 0;
  DateTime saleStartFrom = DateTime.now();
  DateTime saleStartTo = DateTime.now();

  ProductDetailResponse1? mProducts;
  ProductDetailResponse1? productDetailNew;
  ProductDetailResponse1? mainProduct;

  List<ProductDetailResponse1> mProductsList = [];
  List<int> mProductVariationsIds = [];
  List<String?> mProductOptions = [];

  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.transparent);
    afterBuildCreated(() {
      init();
    });
  }

  init() async {
    productDetail();
  }

  Future deleteProductApi() async {
    appStore.setLoading(true);
    setState(() {});
    await deleteProduct(widget.mProId).then((value) {
      toast('lbl_remove_product'.translate);
      finish(context, true);
    }).catchError((onError) {
      print(onError.toString());
      toast('${onError.toString()}');
    });
    appStore.setLoading(false);
  }

  Future productDetail() async {
    appStore.setLoading(true);

    await getProductDetail(widget.mProId).then((res) {
      if (!mounted) return;
      appStore.setLoading(false);
      mProducts = ProductDetailResponse1.fromJson(res);
      if (mProducts != null) {
        productDetailNew = mProducts;
        mainProduct = mProducts;
        rating = double.parse(mainProduct!.averageRating);
        productDetailNew!.variations!.forEach((element) {
          mProductVariationsIds.add(element);
        });
        mProductsList.clear();
        if (mainProduct!.type == "variable") {
          mProductOptions.clear();
          mProductsList.forEach((product) {
            String? option = '';
            product.attributes!.forEach(
              (attribute) {
                if (option!.isNotEmpty) {
                  option = '$option - ${attribute.options}';
                } else {
                  option = attribute.options as String?;
                }
              },
            );
            if (product.onSale!) {
              option = '$option [Sale]';
            }
            mProductOptions.add(option);
          });
          if (mProductOptions.isNotEmpty) mSelectedVariation = mProductOptions.first;
          if (mainProduct!.type == "variable" && mProductsList.isNotEmpty) {
            productDetailNew = mProductsList[0];
            mProducts = mProducts;
          }
        } else if (mainProduct!.type == 'grouped') {
          mIsGroupedProduct = true;
        }
        setPriceDetail();
      }
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  // ignore: missing_return
  void setPriceDetail() {
    setState(() {
      if (productDetailNew!.type != 'grouped') {
        if (productDetailNew!.onSale!) {
          double mrp = double.parse(productDetailNew!.regularPrice!).toDouble();
          double discountPrice = double.parse(productDetailNew!.price!).toDouble();
          discount = ((mrp - discountPrice) / mrp) * 100;
        }
      }
    });
  }

  String getAllAttribute(Attributes attribute) {
    String attributes = "";
    for (var i = 0; i < attribute.options!.length; i++) {
      attributes = attributes + attribute.options![i];
      if (i < attribute.options!.length - 1) {
        attributes = attributes + ", ";
      }
    }
    return attributes;
  }

  @override
  void dispose() {
    setStatusBarColor(primaryColor);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget mMenuWidget() {
      return SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close_sharp,
        child: Icon(Icons.dehaze_outlined),
        buttonSize: Size(52, 52),
        visible: true,
        renderOverlay: true,
        curve: Curves.bounceIn,
        overlayOpacity: 0.2,
        backgroundColor: primaryColor,
        foregroundColor: white,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit).paddingAll(10),
            label: "lbl_Edit".translate,
            labelStyle: primaryTextStyle(),
            labelBackgroundColor: context.scaffoldBackgroundColor,
            onTap: () async {
              bool? res = await AddProductScreen(singleProductResponse: mainProduct, isUpdate: true).launch(context);
              if (res ?? false) {
                setStatusBarColor(primaryColor);
                finish(context, true);
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.delete).paddingAll(10),
            label: "lbl_Delete".translate,
            labelStyle: primaryTextStyle(),
            labelBackgroundColor: context.scaffoldBackgroundColor,
            onTap: () {
              showConfirmDialogCustom(
                context,
                primaryColor: primaryColor,
                onAccept: (_) {
                  deleteProductApi();
                },
                dialogType: DialogType.DELETE,
              );
            },
          ),
        ],
      );
    }

    final body = NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 350,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                finish(context, false);
              },
              icon: Icon(Icons.arrow_back, color: innerBoxIsScrolled ? white : black),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: MediaQuery.of(context).size.width,
                child: mainProduct != null
                    ? Container(
                        height: 350,
                        child: HorizontalList(
                          padding: EdgeInsets.all(0),
                          physics: PageScrollPhysics(),
                          itemCount: mainProduct!.images!.length,
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  ZoomImageScreen(mProductImage: mainProduct!.images![i].src).launch(context);
                                });
                              },
                              child: cachedImage(mainProduct!.images![i].src, height: 450, width: context.width(), fit: BoxFit.cover),
                            );
                          },
                        ),
                      )
                    : 0.height,
              ),
            ),
          )
        ];
      },
      body: Stack(
        children: [
          mainProduct != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailCard(productName: mainProduct!.name, name: 'lbl_name'.translate).visible(mainProduct!.name != null),
                      ProductDetailCard(productName: mainProduct!.type, name: 'lbl_Type'.translate).visible(mainProduct!.type!.isNotEmpty),
                      ProductDetailCard(productName: rating.toString(), name: 'lbl_total_ratting'.translate).visible(rating != 0.0),
                      if (productDetailNew!.type != 'grouped') ProductDetailCard(productName: '${discount.toInt()}%' + "lbl_off1".translate, name: 'lbl_discount_total'.translate),
                      if (productDetailNew!.type != 'grouped')
                        ProductDetailCard(productName: mainProduct!.regularPrice.toString(), name: 'lbl_product_regular_price'.translate).visible(mainProduct!.regularPrice.toString().isNotEmpty),
                      if (productDetailNew!.type != 'grouped') ProductDetailCard(productName: mainProduct!.salePrice, name: 'sale_price'.translate).visible(mainProduct!.salePrice!.isNotEmpty),
                      if (productDetailNew!.type == 'grouped')
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(8),
                          width: context.width(),
                          decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TODO Localization
                              Text("Product Includes", style: boldTextStyle()),
                              10.height,
                              AnimatedListView(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: mainProduct!.groupedProducts!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, i) {
                                  return FutureBuilder(
                                      future: getProductDetail(mainProduct!.groupedProducts![i]),
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          ProductDetailResponse1 productRes= ProductDetailResponse1.fromJson(snap.data as Map<String,dynamic>);
                                           return GestureDetector(
                                            onTap: () {
                                              ProductDetailScreen(mProId: mainProduct!.groupedProducts![i]).launch(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(right: 8, bottom: 8, top: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  cachedImage(productRes.images![0].src, height: 80, width: 80, fit: BoxFit.cover).cornerRadiusWithClipRRect(8),
                                                  4.width,
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(productRes.name!, style: boldTextStyle()).paddingOnly(left: 8, right: 8),
                                                      12.height,
                                                      Row(
                                                        children: [
                                                          PriceWidget(price: productRes.salePrice.toString().validate().isNotEmpty ? productRes.salePrice.toString() : productRes.price.toString().validate(), size: 16),
                                                          4.width,
                                                          PriceWidget(price: productRes.regularPrice.toString(), size: 12, isLineThroughEnabled: true, color: Theme.of(context).textTheme.titleSmall!.color)
                                                              .visible(productRes.salePrice.toString().isNotEmpty),
                                                        ],
                                                      ).paddingOnly(left: 8),
                                                    ],
                                                  ).expand()
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        return snapWidgetHelper(snap);
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ProductDetailCard(productName: mainProduct!.status, name: 'lbl_Status'.translate).visible(mainProduct!.status!.isNotEmpty),
                      mainProduct!.attributes!.length > 0
                          ? Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.all(8),
                              width: context.width(),
                              decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("lbl_additional_information".translate, style: boldTextStyle()),
                                  10.height,
                                  UL(
                                    children: List.generate(
                                      mainProduct!.attributes!.length,
                                      (i) => Row(
                                        children: [
                                          Text(mainProduct!.attributes![i].name + " : ", style: primaryTextStyle(color: appStore.textPrimaryColor)),
                                          6.width,
                                          Expanded(child: Text(getAllAttribute(mainProduct!.attributes![i]), maxLines: 4, style: primaryTextStyle(color: appStore.textSecondaryColor)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      mainProduct!.categories!.length > 0
                          ? Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.all(8),
                              width: context.width(),
                              decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("lbl_Category".translate, style: boldTextStyle()),
                                  10.height,
                                  UL(
                                    children: List.generate(
                                      mainProduct!.categories!.length,
                                      (index) => Text(
                                        mainProduct!.categories![index].name.validate(),
                                        style: primaryTextStyle(color: appStore.textSecondaryColor),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                      mainProduct!.variations!.length > 0
                          ? Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.all(8),
                              width: context.width(),
                              decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("lbl_variation".translate, style: boldTextStyle()),
                                  10.height,
                                  UL(
                                    children: List.generate(
                                      mainProduct!.variations!.length,
                                      (index) => Text(
                                        mainProduct!.variations![index].toString(),
                                        style: primaryTextStyle(color: appStore.textSecondaryColor),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(8),
                        width: context.width(),
                        decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("lbl_upcoming_sale_on_this_item".translate, style: boldTextStyle()),
                            10.height,
                            UL(
                              children: [
                                Text(
                                  "lbl_sale_start_from".translate +
                                      " " +
                                      ' ${mainProduct!.dateOnSaleFrom.toString()} ' +
                                      " " +
                                      "lbl_to".translate +
                                      " " +
                                      '${mainProduct!.dateOnSaleTo.toString()}' +
                                      " " +
                                      "lbl_ge_amazing_discounts_on_the_products".translate,
                                  style: primaryTextStyle(color: appStore.textSecondaryColor),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            )
                          ],
                        ),
                      ).visible(mainProduct!.dateOnSaleFrom != null && mainProduct!.dateOnSaleTo != null),
                      ProductDetailCard(productName: parseHtmlString(mainProduct!.description), name: 'hint_description'.translate).visible(mainProduct!.description!.isNotEmpty),
                      ProductDetailCard(productName: parseHtmlString(mainProduct!.shortDescription), name: 'lbl_short_product_description'.translate).visible(mainProduct!.shortDescription!.isNotEmpty),
                      16.height,
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          body,
          Observer(builder: (_) => Center(child: loading()).visible(appStore.isLoading)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: mMenuWidget(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class ProductDetailCard extends StatelessWidget {
  ProductDetailCard({this.name, this.productName});

  final String? name;
  final String? productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(8),
      width: context.width(),
      decoration: boxDecoration(context, showShadow: false, radius: 12, color: context.dividerColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name!, style: boldTextStyle()),
          10.height,
          Text(productName!.trim(), style: primaryTextStyle(color: appStore.textSecondaryColor), textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
