import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reinmkg/utils/ext/context.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NowcastPage extends StatefulWidget {
  const NowcastPage({super.key});

  @override
  State<NowcastPage> createState() => _NowcastPageState();
}

class _NowcastPageState extends State<NowcastPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://nowcasting.bmkg.go.id/nowcast/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          WebViewWidget(controller: controller),
          _backButton(context),
        ],
      )),
    );
  }

  Widget _backButton(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: context.back,
        child: Container(
          margin: EdgeInsets.only(top: 8.h, left: 8.w),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Icon(Icons.close_rounded),
        ),
      ),
    );
  }
}
