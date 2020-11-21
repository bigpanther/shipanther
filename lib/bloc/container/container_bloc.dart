import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/container/container_repository.dart';
import 'package:trober_sdk/api.dart';

part 'container_event.dart';
part 'container_state.dart';

class ContainerBloc extends Bloc<ContainerEvent, ContainerState> {
  final ContainerRepository _containerRepository;
  ContainerBloc(this._containerRepository) : super(ContainerInitial());

  @override
  Stream<ContainerState> mapEventToState(
    ContainerEvent event,
  ) async* {
    yield ContainerLoading();
    if (event is GetContainer) {
      yield ContainerLoaded(
          await _containerRepository.fetchContainer(event.id));
    }
    if (event is GetContainers) {
      var containers = await _containerRepository.fetchContainers();
      if (event.user.role == UserRole.admin)
        yield ContainersLoadedForTenant(containers, event.user.id);
      if (event.user.role == UserRole.driver)
        yield ContainersLoadedForDriver(containers, event.user.id);
    }
    if (event is UpdateContainer) {
      await _containerRepository.updateContainer(event.id, event.container);
      var containers =
          await _containerRepository.fetchContainersForTenant(null);
      yield ContainersLoadedForTenant(containers, null);
    }
    if (event is CreateContainer) {
      await _containerRepository.createContainer(event.container);
      var containers =
          await _containerRepository.fetchContainersForTenant(null);
      yield ContainersLoadedForTenant(containers, null);
    }
    if (event is DeleteContainer) {
      yield ContainerFailure("Container deletion is not supported");
    }
  }
}
