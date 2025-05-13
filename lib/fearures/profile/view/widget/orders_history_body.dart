import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:angelinashop/core/widgets/app_shimmers.dart';
import 'package:angelinashop/fearures/profile/cubit/order_history_cubit.dart';
import 'package:angelinashop/fearures/profile/cubit/order_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'custom_ordered_item.dart';

class OrdersHistoryBody extends StatelessWidget {
  const OrdersHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        if (state is OrderHistoryLoading) {
          return HorizontalProductItemShimmer();
        } else if (state is OrderHistoryLoaded) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No past orders found.',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: orders.length,
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text('Order #${order.id}', style: TextStyles.k16),
                          Text(DateFormat('dd MMM yyyy').format(order.date),
                              style: TextStyles.k14),
                          Text(
                              '${order.totalAmount.toStringAsFixed(2)}ر.س : Total  ',
                              style: TextStyles.k14),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: order.items.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, i) {
                          return OrderHistoryProductItem(
                              cartItem: order.items[i]);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
