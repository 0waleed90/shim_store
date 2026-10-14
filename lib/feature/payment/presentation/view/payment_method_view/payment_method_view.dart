import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_cubit.dart';

import '../../manger/card_cubit/card_state.dart';
import '../widgets/payment_text_field.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  int selectedPayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method', style: Styles.textStyle32),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SizedBox(height: 10, child: Divider()),
            Expanded(
              child: BlocBuilder<CardCubit, CardState>(
                builder: (context, state) {
                  if (state is CardSuccess) {
                    return ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        return PaymentTextField(
                          cardNumber: state.cards[index].cardNumber,
                          suffixIcon: selectedPayIndex == index
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.circle_outlined),
                          onSuffixIconPressed: () {
                            setState(() {
                              selectedPayIndex = index;
                            });
                          },
                          prefixIcon: context.read<CardCubit>().getCardType(
                            state.cards[index].cardNumber,
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),

            CustomButton(
              borderColor: Colors.black,
              text: '➕  Add New Card',
              color: Colors.white,
              textColor: Colors.black,
              width: 500,
              onTap: () {
                GoRouter.of(context).push(AppRouter.kNewCardView);
              },
            ),
            const SizedBox(height: 20),

            CustomButton(
              text: 'Apply',
              color: Colors.black,
              textColor: Colors.white,
              width: 500,
              onTap: () {
                context.read<CardCubit>().selectPay(selectedPayIndex);
                GoRouter.of(context).pop();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
