import 'package:flutter/material.dart';
import '../main.dart';
import '../models/AttributeModel.dart';
import '../network/rest_apis.dart';
import '../screens/AddAttributeScreen.dart';
import '../screens/ProductTermScreen.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductAttributesWidget extends StatefulWidget {
  static String tag = '/ProductAttributesItemWidget';

  final AttributeModel? data;
  final Function(int?)? onDelete;
  final Function? onUpdate;

  ProductAttributesWidget({this.data, this.onDelete, this.onUpdate});

  @override
  ProductAttributesWidgetState createState() => ProductAttributesWidgetState();
}

class ProductAttributesWidgetState extends State<ProductAttributesWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  void deleteAttributes() {
    hideKeyboard(context);

    appStore.setLoading(true);

    deleteAttributesTerm(attributeId: widget.data!.id, isAttribute: true).then((res) {
      toast('lbl_Delete'.translate);

      widget.onDelete?.call(res.id);
    }).catchError((e) {
      toast(e.toString());
      log(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(widget.data!.name!, style: boldTextStyle(size: 18)).expand(),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithRoundedCorners(backgroundColor: primaryColor.withOpacity(0.2)),
                child: Icon(Icons.edit, size: 14, color: primaryColor),
              ).onTap(
                () async {
                  if (isVendor) {
                    // toast("only admin can change it");
                  }
                  var res = await AddAttributeScreen(attributeData: widget.data, attributeId: widget.data!.id, isUpdate: true).launch(context);
                  if (res != null) {
                    setState(() {});
                    widget.onUpdate?.call();
                  }
                },
              ),
              commonEditButtonComponent(
                  icon: Icons.delete,
                  color: redColor,
                  onCall: () async {
                    if (isVendor) {
                      toast("admin_toast".translate);
                      return;
                    }
                    showConfirmDialogCustom(context, title: "lbl_confirmation_Product_Attributes".translate, onAccept: (_) {
                      deleteAttributes();
                    }, dialogType: DialogType.DELETE, positiveText: 'lbl_Delete'.translate, negativeText: 'lbl_cancel'.translate);
                  }),
            ],
          ),
        ],
      ),
    ).onTap(() {
      ProductTermScreen(attributeId: widget.data!.id.validate(), attributeName: widget.data!.name.validate()).launch(context);
    });
  }
}
