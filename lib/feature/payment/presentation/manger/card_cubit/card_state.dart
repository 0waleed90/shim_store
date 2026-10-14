abstract class CardState {}

class CardInitial extends CardState {}

class CardSuccess extends CardState {
final List cards ;

  CardSuccess({required this.cards});
}

class CardFailure extends CardState {}
