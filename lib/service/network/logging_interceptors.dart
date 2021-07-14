import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:music_factory/utility/utility.dart';

class LoggingInterceptors extends Interceptor {
  int currentRequests = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['customProgress'] == false) {
      return super.onRequest(options, handler);
    }

    ++currentRequests;
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.extra['customProgress'] == false) {
      return super.onResponse(response, handler);
    }

    --currentRequests;
    if (0 >= currentRequests) {
      EasyLoading.dismiss();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    BotToast.showText(
      text: NetworkException(err).getDetail(),
      backgroundColor: Colors.red,
    );

    if (err.response!.extra['customProgress'] == false) {
      return super.onError(err, handler);
    }

    --currentRequests;
    if (0 >= currentRequests) {
      EasyLoading.dismiss();
    }
    super.onError(err, handler);
  }
}
