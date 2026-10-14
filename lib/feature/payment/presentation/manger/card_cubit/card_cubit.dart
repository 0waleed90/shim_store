import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/cib.dart';
import 'package:my_store/core/util/hive_boxes.dart';
import 'package:my_store/feature/payment/presentation/manger/card_cubit/card_state.dart';

import '../../../data/model/card_model.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());
  List<CardModel> cards = [];
  int selectedPayMethod = 0;
  void addNewCard(String cardNumber, String expiryDate, String securityCode) {
    cards.add(
      CardModel(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        securityCode: securityCode,
      ),
    );
    Hive.box(HiveBoxes.basicBox).put(
      HiveBoxes.kCardsBox,
      cards.map((e) => e.toJson()).toList(),
    );
    emit(CardSuccess(cards: cards));
  }

  Iconify getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return Iconify(Bx.bxl_visa);
    } else if (cardNumber.startsWith('5')) {
      return Iconify(Cib.mastercard);
    } else {
      return Iconify(Bx.credit_card);
    }
  }

  void getCard() {
    try {
      var rawData =
          Hive.box(
                HiveBoxes.basicBox,
              ).get(HiveBoxes.kCardsBox, defaultValue: [])
              as List;
      cards = rawData
          .where((e) => e != null)
          .map((e) => CardModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      cards = [];
      Hive.box(HiveBoxes.basicBox).delete(HiveBoxes.kCardsBox);
    }
    emit(CardSuccess(cards: cards));
  }

  void selectPay(int selectPayMethodIndex) {
    selectedPayMethod = selectPayMethodIndex;
    Hive.box(HiveBoxes.basicBox,).put(HiveBoxes.kSelectPayMethodIndexBox, selectPayMethodIndex);
    emit(CardSuccess(cards: cards));
  }

  void getSelectPay() {
    selectedPayMethod = Hive.box(
      HiveBoxes.basicBox,
    ).get(HiveBoxes.kSelectPayMethodIndexBox, defaultValue: 0);
    emit(CardSuccess(cards: cards));
  }
}
