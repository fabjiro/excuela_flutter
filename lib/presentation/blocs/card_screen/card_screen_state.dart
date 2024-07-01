part of 'card_screen_bloc.dart';

class CardScreenState extends Equatable {
  const CardScreenState({
    this.countLike = 0,
  });

  final int countLike;

  CardScreenState copyWith({
    int? countLike,
  }) =>
      CardScreenState(
        countLike: countLike ?? this.countLike,
      );

  @override
  List<Object> get props => [countLike];
}
