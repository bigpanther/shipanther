part of 'container_bloc.dart';

@immutable
abstract class ContainerState {
  const ContainerState();
}

class ContainerInitial extends ContainerState {}

class ContainerLoading extends ContainerState {}

class ContainerLoaded extends ContainerState {
  final Container container;
  const ContainerLoaded(this.container);
}

class ContainersLoadedForDriver extends ContainerState {
  final List<Container> containers;
  final String driverId;
  const ContainersLoadedForDriver(this.containers, this.driverId);
}

class ContainersLoadedForTenant extends ContainerState {
  final List<Container> containers;
  final String tenantId;
  const ContainersLoadedForTenant(this.containers, this.tenantId);
}

class ContainerFailure extends ContainerState {
  final String message;
  const ContainerFailure(this.message);
}
