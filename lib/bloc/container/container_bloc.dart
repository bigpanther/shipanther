import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'container_event.dart';
part 'container_state.dart';

class ContainerBloc extends Bloc<ContainerEvent, ContainerState> {
  ContainerBloc() : super(ContainerInitial());

  @override
  Stream<ContainerState> mapEventToState(
    ContainerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
