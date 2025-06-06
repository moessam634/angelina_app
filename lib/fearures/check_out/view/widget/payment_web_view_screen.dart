import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/styles/colors_app.dart';
import 'package:angelinashop/core/widgets/app_shimmers.dart';
import 'package:angelinashop/fearures/profile/cubit/order_history_cubit.dart';
import 'package:angelinashop/fearures/switcher/view/screen/switcher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/notification_service.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/model/model/cart_model.dart';
import '../../../profile/model/models/orders_history_model.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final VoidCallback onPaymentSuccess;

  const PaymentWebViewScreen(
      {super.key, required this.paymentUrl, required this.onPaymentSuccess});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasProcessedPayment = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (_hasProcessedPayment) {
              return NavigationDecision.prevent;
            }
            final uri = Uri.tryParse(request.url);
            final successParam = uri?.queryParameters['success'];
            // if (successParam == 'true') {
            //   _hasProcessedPayment = true;
            //   widget.onPaymentSuccess();
            //   context.read<OrderHistoryCubit>().addOrder(sl());
            //   context.read<CartCubit>().clearCart();
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text("تمت عملية الدفع بنجاح")),
            //   );
            //   Future.delayed(const Duration(milliseconds: 500), () {
            //     NavigationHelper.pushReplacement(
            //       context: context,
            //       destination: const SwitcherScreen(),
            //     );
            //   });
            //   return NavigationDecision.prevent;
            // }
            if (successParam == 'true') {
              _hasProcessedPayment = true;
              final cartCubit = context.read<CartCubit>();
              final orderHistoryCubit = context.read<OrderHistoryCubit>();
              final order = OrdersHistoryModel(
                id: DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(), // unique ID
                date: DateTime.now(),
                items: List<CartItemModel>.from(cartCubit.items),
                totalAmount: cartCubit.total,
              );
              await orderHistoryCubit.addOrder(order);
              await cartCubit.clearCart();
              widget.onPaymentSuccess();
              await NotificationService().showNotification(
                id: 1,
                title: 'تم الدفع بنجاح',
                body: 'شكراً لطلبك. تم إكمال عملية الدفع بنجاح.',
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  NavigationHelper.pushReplacement(
                    context: context,
                    destination: const SwitcherScreen(),
                  );
                }
              });
              return NavigationDecision.prevent;
            }

            if (successParam == 'false') {
              _hasProcessedPayment = true;
              await NotificationService().showNotification(
                id: 2,
                title: 'فشل الدفع',
                body: 'لم تتم عملية الدفع. الرجاء المحاولة مرة أخرى.',
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) Navigator.pop(context);
              });
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog before leaving payment screen
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("إلغاء عملية الدفع"),
            content: const Text("هل أنت متأكد من إلغاء عملية الدفع؟"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("لا"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("نعم"),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('الدفع',
              style: TextStyles.k24.copyWith(color: ColorsApp.kPrimaryColor)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              // Show confirmation dialog
              final shouldClose = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("إلغاء عملية الدفع"),
                  content: const Text("هل أنت متأكد من إلغاء عملية الدفع؟"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("لا"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("نعم"),
                    ),
                  ],
                ),
              );

              if (shouldClose == true) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const PaymentShimmer(),
          ],
        ),
      ),
    );
  }
}
