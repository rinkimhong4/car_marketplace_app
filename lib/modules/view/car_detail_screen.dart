import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:car_marketplace_app/core/models/product_detail_model.dart';

class CarDetailScreen extends StatefulWidget {
  final ProductDetail product;

  const CarDetailScreen({super.key, required this.product});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  Flutter3DController? _controller;
  double _orbitY = 75.0;
  int _selectedColorIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = Flutter3DController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppTheme.secondarySwatch,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car view
                  Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _orbitY += details.delta.dx * 0.5;
                              _controller?.setCameraOrbit(-35, _orbitY, 90);
                            });
                          },
                          child: Flutter3DViewer(
                            src: widget.product.model3dUrl,
                            controller: _controller!,
                            progressBarColor: Colors.transparent,
                            onLoad: (sceneName) =>
                                _controller?.setCameraOrbit(-35, _orbitY, 90),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                shape: BoxShape.circle),
                            child: const Center(
                              child: Text(
                                '360°',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Color swatches
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.product.availableColors.length,
                      (index) => _colorChip(
                          index, widget.product.availableColors[index]),
                    ),
                  ),
                  // Title and rating
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.title,
                            style: AppTextStyle.medium18(color: Colors.black)),
                        Row(
                          children: [
                            Chip(
                              label: Text(widget.product.condition,
                                  style:
                                      AppTextStyle.bold12(color: Colors.black)),
                              backgroundColor:
                                  Colors.black.withValues(alpha: 0.2),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber[600],
                            ),
                            Text(
                                '${widget.product.rating} (${widget.product.reviewCount} reviews)',
                                style:
                                    AppTextStyle.medium18(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Description
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                            style: AppTextStyle.medium18(color: Colors.black)),
                        const SizedBox(height: 8),
                        Text(widget.product.description,
                            style: AppTextStyle.regular14(color: Colors.black)),
                      ],
                    ),
                  ),
                  // Gallery
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gallery Photos',
                          style: AppTextStyle.bold18(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              widget.product.galleryImages.length,
                              (index) => Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        widget.product.galleryImages[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Footers
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 18),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          backgroundImage: widget.product.storeLogo.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  widget.product.storeLogo)
                              : null,
                          child: widget.product.storeLogo.isEmpty
                              ? const Icon(Icons.store, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${widget.product.storeName} •\n${widget.product.storeDescription}',
                            style: AppTextStyle.bold18(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            RouteView.reivews.go();
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.call,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // Price and button
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style:
                                    AppTextStyle.regular13(color: Colors.black),
                              ),
                              Text(
                                '\$${widget.product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: AppTextStyle.bold28(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 6,
                            shadowColor: Colors.black.withValues(alpha: 0.8),
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 18,
                            ),
                          ),
                          child: const Text('Make an Offer'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorChip(int index, Color color) {
    bool selected = _selectedColorIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedColorIndex = index),
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 0.5, color: Colors.black45),
          shape: BoxShape.circle,
        ),
        child: selected
            ? const Icon(Icons.check, color: Colors.white, size: 14)
            : null,
      ),
    );
  }
}
