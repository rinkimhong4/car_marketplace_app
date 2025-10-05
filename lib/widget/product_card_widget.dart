import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/routes/app_routes.dart';
import 'package:car_marketplace_app/core/models/product_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductDetail product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
        label: 'Product card for ${widget.product.title}',
        hint: 'Tap to view product details',
        child: GestureDetector(
          onTap: () {
            RouteView.carDetail.go(arguments: widget.product);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withValues(alpha: 0.1),
              //     spreadRadius: 1,
              //     blurRadius: 4,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with favorite button
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.galleryImages.isNotEmpty
                              ? widget.product.galleryImages[0]
                              : 'https://source.unsplash.com/featured/?car',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: _isFavorite ? Colors.red[600] : Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Content below image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.product.title.split(' ').take(3).join(' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Rating & condition
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                widget.product.rating.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.product.condition,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Price
                      Text(
                        '\$${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
