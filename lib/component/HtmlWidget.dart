import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

import '../main.dart';

class HtmlWidget extends StatelessWidget {
  final String? postContent;
  final Color? color;

  HtmlWidget({this.postContent, this.color});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: postContent ?? '',
      onLinkTap: (String? url, Map<String, String> attributes, dom.Element? element) {
        if (url != null) {
          mLaunchUrl(url);
        }
      },
      style: {
        "*": Style(
          color: appStore.textPrimaryColor,
          fontSize: FontSize(16),
        ),
        "embed": Style(
          color: color ?? Colors.transparent,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: FontSize(16),
        ),
        "a": Style(
          color: color ?? Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: FontSize(16),
        ),
        "img": Style(
          width: Width(MediaQuery.of(context).size.width),
          padding: HtmlPaddings.only(bottom: 8),
          fontSize: FontSize(16),
        ),
      },
    );
  }
}

Future<void> mLaunchUrl(String url, {bool forceWebView = false}) async {
  log(url);
  final uri = Uri.tryParse(url);
  if (uri != null && await canLaunch(url)) {
    await launch(url);
  } else {
    toast('Invalid URL: $url');
  }
}
