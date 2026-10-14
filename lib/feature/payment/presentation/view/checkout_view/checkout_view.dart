import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_cubit.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_state.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_cubit.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_state.dart';
import 'package:my_store/feature/payment/presentation/view/widgets/payment_text_field.dart';

import '../../../../../core/util/app_router.dart';
import '../../../../home/presentation/view/widgets/my_cart_view/price_detils.dart';
import 'cards_list_view.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.total});
  final int total;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: Styles.textStyle32),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 10, child: Divider()),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text('Delivery Address', style: Styles.textStyle22),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kNewAddressView);
                    },
                    child: Text(
                      'Change',
                      style: Styles.textStyle20.copyWith(
                        fontWeight: .w500,
                        decoration: .underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is AddressSuccess) {
                    return Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 34),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              state.addressNickName,
                              style: Styles.textStyle20,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                state.fullAddress,
                                overflow: .ellipsis,
                                style: Styles.textStyle20.copyWith(
                                  fontWeight: .w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 40, child: Divider()),

              const Text('Payment Method', style: Styles.textStyle22),
              const SizedBox(height: 16),
              CardListView(onPaySelected: (payment) {}),
              const SizedBox(height: 11),
              BlocBuilder<CardCubit, CardState>(
                builder: (context, state) {
                  final cardCubit = context.read<CardCubit>();
                  if (cardCubit.cards.isNotEmpty &&
                      cardCubit.selectedPayMethod < cardCubit.cards.length) {
                    final selectedCard =
                        cardCubit.cards[cardCubit.selectedPayMethod];

                    return PaymentTextField(
                      cardNumber: selectedCard.cardNumber,
                      suffixIcon: Icon(Icons.edit),
                      prefixIcon: cardCubit.getCardType(
                        selectedCard.cardNumber,
                      ),
                      onSuffixIconPressed: () {
                        GoRouter.of(context).push(AppRouter.kPaymentMethodView);
                      },
                    );
                  } else {
                    return PaymentTextField(
                      cardNumber: 'add a new card',
                      suffixIcon: Icon(Icons.add),
                      onSuffixIconPressed: () {
                        GoRouter.of(context).push(AppRouter.kNewCardView);
                      },
                      prefixIcon: Iconify(Bx.credit_card),
                    );
                  }
                },
              ),
              SizedBox(height: 35, child: Divider()),
              const SizedBox(height: 10),
              Text('Order Summary', style: Styles.textStyle22),
              PriceDetails(
                leftText: 'Sub-total',
                rightText: "${total.toString()} \$",
              ),
              PriceDetails(leftText: 'VAT (%)', rightText: r'$ 0.00'),
              PriceDetails(leftText: 'Shipping fee', rightText: r'$ 80'),

              Divider(),
              PriceDetails(
                leftText: 'Total',
                rightText: "${total.toString()} \$",
              ),
              SizedBox(height: 80),
              CustomButton(
                text: 'Place Order',
                color: Colors.black,
                textColor: Colors.white,
                width: 500,
                onTap: () {
                  context.read<ProductCubit>().clearCart();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        body: Center(
                          child: Container(
                            width: 341,
                            height: 300,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 78,
                                  color: Colors.green,
                                ),
                                Text(
                                  'Congratulations!',
                                  style: Styles.textStyle24,
                                ),
                                Text('Your order has been placed.'),
                                CustomButton(
                                  text: 'ok',
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  width: 300,
                                  onTap: () {
                                    GoRouter.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
