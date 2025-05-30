import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../models/AttributeModel.dart';
import '../network/rest_apis.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class AddAttributeScreen extends StatefulWidget {
  static String tag = '/AddAttributeScreen';
  final AttributeModel? attributeData;
  final int? attributeId;
  final Function? onUpdate;
  final bool? isUpdate;

  AddAttributeScreen({this.attributeData, this.attributeId, this.onUpdate, this.isUpdate});

  @override
  AddAttributeScreenState createState() => AddAttributeScreenState();
}

class AddAttributeScreenState extends State<AddAttributeScreen> {
  TextEditingController attributeNameCont = TextEditingController();
  TextEditingController slugCont = TextEditingController();

  FocusNode descriptionFocus = FocusNode();
  bool mArchives = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // toast('Back');
    if(widget.isUpdate.validate()) {
      attributeNameCont.text = widget.attributeData!.name.toString();
      slugCont.text = widget.attributeData!.slug.toString();
      mArchives = widget.attributeData!.hasArchives!;
    }
  }

  Future<void> addAttributes() async {
    //var request = {'name': attributeNameCont.text};
    var request;
    if(widget.isUpdate.validate()){
      appStore.setLoading(true);
      request = {
        "id" : widget.attributeId,
        "name": attributeNameCont.text,
        "slug": slugCont.text,
        "type": "select",
        "order_by": "menu_order",
        "has_archives": mArchives,
      };
      await editAttribute(attributeId: widget.attributeId,request: request).then((res) {
        // TODO Localization
        toast("Successfully updated Attribute");
        finish(context, res);
      }).catchError((e) {
        toast("${e['message']}");
      }).whenComplete(() => appStore.setLoading(false));
    }else{
      appStore.setLoading(true);
      request = {
        "name": attributeNameCont.text,
        "slug": slugCont.text,
        "type": "select",
        "order_by": "menu_order",
        "has_archives": mArchives,
      };
      await addAttribute(req: request).then((res) {
        toast('lbl_Add_Attribute_successfully'.translate);
        log('res:${res.toString()}');
        finish(context, res);
      }).catchError((e) {
        toast("${e['message']}");
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.isUpdate == true ? "lbl_Update_Attribute".translate : 'lbl_Add_Attribute'.translate, showBack: true, color: primaryColor, textColor: white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                AppTextField(
                  controller: attributeNameCont,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, 'lbl_Product_Attribute'.translate),
                  nextFocus: descriptionFocus,
                  autoFocus: true,
                ),
                16.height,
                AppTextField(
                  controller: slugCont,
                  focus: descriptionFocus,
                  textFieldType: TextFieldType.NAME,
                  cursorColor: appStore.isDarkModeOn ? white : black,
                  decoration: inputDecoration(context, 'lbl_Slug'.translate),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                8.height,
                Row(
                  children: [
                    CustomTheme(
                      child: Checkbox(
                        focusColor: primaryColor,
                        activeColor: primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: mArchives,
                        onChanged: (bool? value) async {
                          mArchives = !mArchives;
                          setState(() {});
                        },
                      ),
                    ),

                    Text("lbl_eneble".translate, style: secondaryTextStyle()).onTap(() async {
                      mArchives = !mArchives;
                      setState(() {});
                    }),
                  ],
                ),
                16.height,
                AppButton(
                  text: widget.isUpdate == true ? "lbl_Update_Attribute".translate : 'lbl_Add_Attribute'.translate,
                  color: primaryColor,
                  textColor: white,
                  width: context.width(),
                  onTap: () {
                    hideKeyboard(context);

                    addAttributes();
                  },
                ),
              ],
            ),
          ),
          Observer(builder: (_) => loading().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
