import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'card_screen_event.dart';
part 'card_screen_state.dart';

class CardScreenBloc extends Bloc<CardScreenEvent, CardScreenState> {
  CardScreenBloc() : super(const CardScreenState()) {
    on<AddLike>(_addLike);
  }

  void _addLike(AddLike event, Emitter<CardScreenState> emit) {
    emit(state.copyWith(countLike: state.countLike + 1));
  }
}
