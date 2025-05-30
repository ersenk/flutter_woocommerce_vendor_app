import 'package:flutter/material.dart';
import '../main.dart';
import '../models/ProductDetailResponse.dart';
import '../screens/ProductDetailScreen.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstants.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductItemWidget extends StatefulWidget {
  static String tag = '/ProductItemWidget';
  final ProductDetailResponse1? product;
  final Function? onDelete;
  final Function? onUpdate;

  ProductItemWidget({this.product, this.onDelete, this.onUpdate});

  @override
  ProductItemWidgetState createState() => ProductItemWidgetState();
}

class ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String? img = widget.product!.images!.isNotEmpty ? widget.product!.images!.first.src : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              cachedImage(img.validate(), height: 80, width: 80, fit: BoxFit.cover).cornerRadiusWithClipRRect(8),
              mSale(widget.product!),
            ],
          ),
        ),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product!.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: primaryTextStyle(size: 16)),
            8.height,
            Row(
              children: [
                PriceWidget(
                  price: widget.product!.onSale == true
                      ? widget.product!.salePrice.isNotEmpty
                          ? widget.product!.salePrice
                          : widget.product!.price
                      : widget.product!.regularPrice!.isNotEmpty
                          ? widget.product!.regularPrice
                          : widget.product!.price,
                  size: 16,
                  color: primaryColor,
                ),
                4.width,
                PriceWidget(
                  price: widget.product!.regularPrice.toString(),
                  size: 16,
                  isLineThroughEnabled: true,
                  color: appStore.textPrimaryColor,
                ).visible(widget.product!.salePrice.toString().isNotEmpty && widget.product!.onSale == true),
              ],
            ).visible(!widget.product!.type!.contains("grouped")).paddingOnly(bottom: 8),
            2.height,
            Row(
              children: [
                Text('${'lbl_stock_quantity'.translate} : '.toUpperCase(), style: primaryTextStyle(size: 14)),
                widget.product!.stockQuantity != null ? Text(widget.product!.stockQuantity.toString(), style: boldTextStyle(size: 16)) : SizedBox(),
              ],
            ).visible(widget.product!.stockQuantity != null),
            2.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.ideographic,
              children: [
                (getStringAsync(USER_ROLE) == 'seller' ? (widget.product!.inStock.validate()) : (widget.product!.stockStatus??"") == 'instock')
                    ? Text('lbl_stock'.translate.toUpperCase(), style: primaryTextStyle(color: Colors.green, size: 14)).expand()
                    : Text('lbl_out_of_stock'.translate.toUpperCase(), style: primaryTextStyle(color: Colors.red, size: 14)).expand(),
                8.width,
                Text('${widget.product!.status}'.toUpperCase(), maxLines: 1, overflow: TextOverflow.ellipsis, style: primaryTextStyle(size: 16, color: appStore.textSecondaryColor)),
              ],
            ),
          ],
        ).expand(),
        Icon(Icons.arrow_forward_ios, size: 12, color: appStore.iconSecondaryColor),
        15.width,
      ],
    ).onTap(() async {
      var res = await ProductDetailScreen(mProId: widget.product!.id).launch(context);
      log('res:$res');
      if (res == true) {
        widget.onUpdate?.call();
        setState(() {});
      }
    });
  }
}
