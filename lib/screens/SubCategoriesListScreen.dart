import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../component/CategoryItemWidget.dart';
import '../models/CategoryResponse.dart';
import '../network/rest_apis.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoriesListScreen extends StatefulWidget {
  static String tag = '/SubCategoriesListScreen';

  final int? categoryId;

  SubCategoriesListScreen({this.categoryId});

  @override
  SubCategoriesListScreenState createState() => SubCategoriesListScreenState();
}

class SubCategoriesListScreenState extends State<SubCategoriesListScreen> {
  AsyncMemoizer asyncMemoizer = AsyncMemoizer<List<CategoryResponse>>();

  List<CategoryResponse>? categoryList = [];
  CategoryResponse data = CategoryResponse();

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
    return Scaffold(
      appBar: appBarWidget("lbl_Category".translate, showBack: true, color: primaryColor, textColor: white),
      body: FutureBuilder<List<CategoryResponse>>(
          future: asyncMemoizer.runOnce(() => getSubCategories(widget.categoryId)).then((value) => value as List<CategoryResponse>),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data!=null && snap.data!.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      AlignedGridView.count(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snap.data!.length,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        padding: EdgeInsets.all(12),
                        itemBuilder: (context, i) {
                          CategoryResponse data = snap.data![i];
                          return CategoryItemWidget(data: data, index: i, categoryList: categoryList,onDelete: (){
                            snap.data!.remove(data);
                            setState(() { });
                          });
                        },

                      ),
                      60.height,
                    ],
                  ),
                );
              } else {
                return NoDataFound(
                    title: 'no_sub_category'.translate,
                    onPressed: () {
                      finish(context);
                    });
              }
            }
            return snapWidgetHelper(
              snap,
              errorWidget: Container(
                child: Text(snap.error.toString().validate(), style: primaryTextStyle()).paddingAll(16).center(),
                height: context.height(),
                width: context.width(),
              ),
            );
          }),
    );
  }
}
