import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/container/container_repository.dart';
import 'package:trober_sdk/api.dart';

part 'container_event.dart';
part 'container_state.dart';

class ContainerBloc extends Bloc<ContainerEvent, ContainerState> {
  ContainerBloc(this._containerRepository) : super(ContainerInitial());
  final ContainerRepository _containerRepository;

  @override
  Stream<ContainerState> mapEventToState(
    ContainerEvent event,
  ) async* {
    yield ContainerLoading();
    try {
      if (event is GetContainer) {
        yield ContainerLoaded(
            await _containerRepository.fetchContainer(event.id));
      }
      if (event is GetContainers) {
        final containers = await _containerRepository.fetchContainers();
        yield ContainersLoaded(containers);
      }
      if (event is UpdateContainer) {
        await _containerRepository.updateContainer(event.id, event.container);
        final containers = await _containerRepository.fetchContainers();
        yield ContainersLoaded(containers);
      }
      if (event is CreateContainer) {
        await _containerRepository.createContainer(event.container);
        final containers = await _containerRepository.fetchContainers();
        yield ContainersLoaded(containers);
      }
      if (event is DeleteContainer) {
        yield const ContainerFailure('Container deletion is not supported');
      }
    } catch (e) {
      yield ContainerFailure('Request failed: $e');
    }
  }
}
