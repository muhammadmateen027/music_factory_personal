import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerEffects on Widget {
  Shimmer getShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.8),
      highlightColor: Colors.white,
      child:this,
    );
  }
}