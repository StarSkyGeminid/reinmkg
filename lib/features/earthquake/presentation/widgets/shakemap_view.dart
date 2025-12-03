import 'package:flutter/material.dart';


class ShakeMapView extends StatefulWidget {
  const ShakeMapView({
    super.key,
    required this.eventId,
    this.dragableScrollableController,
    this.scrollController,
  });

  final String eventId;
  final DraggableScrollableController? dragableScrollableController;
  final ScrollController? scrollController;

  @override
  State<ShakeMapView> createState() => _ShakeMapViewState();
}

class _ShakeMapViewState extends State<ShakeMapView>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  bool imageExist = true;

  final GlobalKey sizeKey = GlobalKey();

  double lastHeight = 0;

  late final AnimationController _controller;

  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    lastHeight = widget.dragableScrollableController?.size ?? 50;

    super.initState();
  }

  void _runExpandCheck() {
    setState(() {
      isExpanded = !isExpanded;

      if (isExpanded) {
        lastHeight = widget.dragableScrollableController?.size ?? 50;

        _controller.forward(from: 0.0);

        widget.dragableScrollableController?.animateTo(
          1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );

        _scrollToSelectedContent(sizeKey);
      } else {
        _controller.reverse(from: 1.0);

        widget.dragableScrollableController?.size;

        widget.dragableScrollableController?.animateTo(
          lastHeight,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  void _scrollToSelectedContent(GlobalKey expansionTileKey) {
    final keyContext = expansionTileKey.currentContext;

    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 210)).then((value) {
        widget.scrollController?.animateTo(
          widget.scrollController!.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }

  @override
  void didUpdateWidget(ShakeMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      isExpanded = false;
    });

    _controller.reverse(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return imageExist
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _showImageButton(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _imageView(),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  ClipRRect _imageView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: _sizeAnimation,
        child: Image.network(
          'https://bmkg-content-inatews.storage.googleapis.com/${widget.eventId}',
          key: sizeKey,
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                imageExist = false;
              });
            });

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Align _showImageButton() {
    final showHideText = isExpanded
        ? 'Hide Shake Map'
        : 'Show Shake Map';

    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: _runExpandCheck,
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: showHideText),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: RotationTransition(
                  turns: Tween(begin: 0.75, end: 0.25).animate(_controller),
                  child: const Icon(Icons.arrow_back_ios_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
