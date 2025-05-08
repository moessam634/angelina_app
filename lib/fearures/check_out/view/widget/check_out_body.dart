import 'package:angelinashop/core/helper/navigation_helper.dart';
import 'package:angelinashop/core/widgets/custom_snack_bar.dart';
import 'package:angelinashop/fearures/cart/cubit/cart_cubit.dart';
import 'package:angelinashop/fearures/check_out/view/widget/custom_row_text_field.dart';
import 'package:angelinashop/fearures/check_out/view/widget/payment_web_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/validation/auth_validation.dart';
import '../../../../core/widgets/app_shimmers.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/check_out_cubit.dart';
import '../../cubit/check_out_state.dart';
import '../../cubit/pay_mob_cubit/pay_mob__cubit.dart';
import '../../model/models/orders_model.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _buildingController = TextEditingController();
  final _streetController = TextEditingController();
  final _floorController = TextEditingController();
  final _apartmentController = TextEditingController();

  bool _isProcessing = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _buildingController.dispose();
    _streetController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  void _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isProcessing) return; // Prevent multiple submissions
    setState(() {
      _isProcessing = true;
    });
    final cartCubit = context.read<CartCubit>();
    final checkoutCubit = context.read<CheckOutCubit>();
    final payMobCubit = context.read<PayMobCubit>();
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("جاري تجهيز الدفع...")),
      );
      // 1. Create billing info
      final billing = Billing(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        address1: _streetController.text,
        address2: _buildingController.text,
        city: _cityController.text,
        state: _floorController.text,
        postcode: _cityController.text,
        country: _countryController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      // 2. Prepare order items
      final lineItems = cartCubit.items.map((item) {
        return LineItem(productId: item.product.id, quantity: item.quantity);
      }).toList();
      // 3. Construct full order model
      final order = OrdersModel(
        paymentMethod: "cod",
        paymentMethodTitle: "Cash on Delivery",
        setPaid: true,
        billing: billing,
        lineItems: lineItems,
      );
      // 4. Use correct amount calculation
      final amount = cartCubit.total;
      // 5. Get payment key
      final paymentKey = await payMobCubit.getPaymentKey(amount, "EGP");
      // 6. Build payment URL
      final paymentUrl =
          "https://accept.paymob.com/api/acceptance/iframes/915615?payment_token=$paymentKey";
      // 7. Navigate to payment screen
      if (mounted) {
        NavigationHelper.push(
            context: context,
            destination: PaymentWebViewScreen(
                paymentUrl: paymentUrl,
                onPaymentSuccess: () {
                  // This will be called when payment is successful
                  checkoutCubit.submitOrder(order);
                }));
      }
    } catch (e) {
      if (mounted) {
        customSnackBar(
            context: context,
            text:
                "فشل في تجهيز الدفع: يرجى التحقق من البيانات والمحاولة مرة أخرى",
            backgroundColor: Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<CheckOutCubit, CheckOutState>(
            listener: (context, state) {
          if (state is CheckOutSuccess) {
            customSnackBar(context: context, text: "تم تقديم الطلب بنجاح!");
          } else if (state is CheckOutError) {
            customSnackBar(
                context: context, text: "لم نتمكن من اكمال البيانات");
          }
        }, builder: (context, state) {
          if (state is CheckOutLoading) {
            return const CheckoutFormShimmer();
          }
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    CustomTextFormField(
                        hintText: "الاسم الأول",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                        validator: MyValidators.fullNameValidator),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      hintText: "الاسم الثاني",
                      hintStyle: TextStyles.k16.copyWith(
                          color: ColorsApp.kLightGreyColor,
                          fontWeight: FontWeight.w400),
                      radius: 8.r,
                      fillColor: Colors.white,
                      focusedFillColor: Colors.blueGrey.shade50,
                      keyboardType: TextInputType.text,
                      controller: _lastNameController,
                      validator: MyValidators.fullNameValidator,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                        hintText: "البريد الإلكتروني",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: MyValidators.emailValidator),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                        hintText: "رقم الهاتف",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: MyValidators.phoneValidator),
                    SizedBox(height: 20.h),
                    CustomRowTextField(
                      child1: CustomTextFormField(
                        hintText: "المدينة",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _cityController,
                        validator: MyValidators.cityValidator,
                      ),
                      child2: CustomTextFormField(
                        hintText: "الدولة",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _countryController,
                        validator: MyValidators.countryValidator,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomRowTextField(
                      child1: CustomTextFormField(
                        hintText: "رقم المبنى",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _buildingController,
                        validator: MyValidators.buildingValidator,
                      ),
                      child2: CustomTextFormField(
                        hintText: "اسم الشارع",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _streetController,
                        validator: MyValidators.streetValidator,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomRowTextField(
                      child1: CustomTextFormField(
                        hintText: "رقم الدور",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _floorController,
                        validator: MyValidators.floorValidator,
                      ),
                      child2: CustomTextFormField(
                        hintText: "رقم الشقة",
                        hintStyle: TextStyles.k16.copyWith(
                            color: ColorsApp.kLightGreyColor,
                            fontWeight: FontWeight.w400),
                        radius: 8.r,
                        fillColor: Colors.white,
                        focusedFillColor: Colors.blueGrey.shade50,
                        keyboardType: TextInputType.text,
                        controller: _apartmentController,
                        validator: MyValidators.apartmentValidator,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'متابعه الدفع',
                      verticalPadding: 10.h,
                      radius: 10.r,
                      style: TextStyles.k16.copyWith(color: Colors.white),
                      onTap: _submitOrder,
                      disabled: _isProcessing,
                    )
                  ])));
        }),
      ),
    );
  }
}
