import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/core/util/widgets/custom_text_field.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_cubit.dart';

class NewCardView extends StatefulWidget {
  const NewCardView({super.key});

  @override
  State<NewCardView> createState() => _NewCardViewState();
}

class _NewCardViewState extends State<NewCardView> {
  bool isCardNumberFull = false;
  bool isExpiryDateFull = false;
  bool isSecurityCodeFull = false;
  bool canAddCart = true;
  String cardNumber = '';
  String expiryDate = '';
  String securityCode = '';
  bool checkCanAddCart() {
    setState(() {
      canAddCart = isCardNumberFull && isExpiryDateFull && isSecurityCodeFull;
    });
    return canAddCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Card', style: Styles.textStyle32),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 10, child: Divider()),
            Text('Add Debit or Credit Card', style: Styles.textStyle22),
            SizedBox(height: 20),
            Text('Card Number', style: Styles.textStyle22),
            SizedBox(height: 10),
            CustomTextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    cardNumber = value;
                    isCardNumberFull = true;
                  });
                }
              },
              hintText: 'Enter your card number',
              readOnly: false,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'Expiry Date',
                        style: Styles.textStyle20.copyWith(fontWeight: .w500),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              expiryDate = value;
                              isExpiryDateFull = true;
                            });
                          }
                        },
                        hintText: 'MM/YY',
                        readOnly: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'Security Code',
                        style: Styles.textStyle20.copyWith(fontWeight: .w500),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              securityCode = value;
                              isSecurityCodeFull = true;
                            });
                          }
                        },
                        hintText: 'CVC',
                        readOnly: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              text: 'Add Card',
              color: checkCanAddCart() ? Colors.black : Color(0xffC4C4C4),
              textColor: Color(0xfff8f8f8),
              width: 500,
              onTap: () {
                if (checkCanAddCart()) {
                  Navigator.of(context).pop();
                  context.read<CardCubit>().addNewCard(
                    cardNumber,
                    expiryDate,
                    securityCode,
                  );
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
