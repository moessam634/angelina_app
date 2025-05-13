import 'package:angelinashop/fearures/profile/cubit/order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:angelinashop/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/orders_history_body.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryCubit()..loadOrderHistory(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: const Text("Order History"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 20.sp))
            ],
          ),
          body: const OrdersHistoryBody(), // Don't pass orders manually!
        ),
      ),
    );
  }
}
