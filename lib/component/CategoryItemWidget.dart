import 'package:flutter/material.dart';
import '../main.dart';
import '../models/CategoryResponse.dart';
import '../network/rest_apis.dart';
import '../screens/SubCategoriesListScreen.dart';
import '../screens/UpdateCategoryScreen.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppImages.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryItemWidget extends StatefulWidget {
  final List<CategoryResponse>? categoryList;
  final CategoryResponse? data;
  final Function()? onDelete;
  final int? index;

  CategoryItemWidget({this.categoryList, this.data, this.index,this.onDelete});

  @override
  _CategoryItemWidgetState createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  Future<void> deleteCategories() async {
    hideKeyboard(context);

    appStore.setLoading(true);

    deleteCategory(categoryId: widget.data!.id).then((res) {
      toast('successfully_deleted');
      widget.onDelete?.call();
    }).catchError((error) {
      log(error.toString());
      toast(error.toString().validate());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration(context, radius: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cachedImage(widget.data!.image != null ? widget.data!.image!.src.validate() : ic_placeHolder, height: 140, width: context.width(), fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(defaultRadius),
          6.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(parseHtmlString(widget.data!.name.validate()), style: primaryTextStyle()).expand(),
              commonEditButtonComponent(
                  icon: Icons.edit,
                  color: primaryColor,
                  onCall: () async {
                    if (isVendor) {
                      toast("admin_toast".translate);
                      return;
                    }
                    bool? res = await UpdateCategoryScreen(categoryList: widget.categoryList, categoryData: widget.data).launch(context);

                    if (res ?? false) {
                      setState(() {});
                    }
                  }),
              commonEditButtonComponent(
                  icon: Icons.delete,
                  color: redColor,
                  onCall: () async {
                    showConfirmDialogCustom(context, title: "lbl_confirmation_Delete_Category".translate, onAccept: (_) {
                      deleteCategories();
                    }, dialogType: DialogType.DELETE, negativeText: 'lbl_cancel'.translate, positiveText: 'lbl_Delete'.translate);
                  }),
            ],
          ).paddingOnly(left: 8, right: 6, bottom: 8),
        ],
      ),
    ).onTap(() {
      if (isVendor) {
        toast("admin_toast".translate);
        return;
      }
      SubCategoriesListScreen(categoryId: widget.data!.id.validate()).launch(context);
    });
  }
}
