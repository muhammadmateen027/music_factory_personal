import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Will use this shimmer effect as a loading architecture in detail page

extension ShimmerEffects on Widget {
  Shimmer getShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.8),
      highlightColor: Colors.white,
      child:this,
    );
  }
}