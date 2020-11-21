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

// class ContainersLoadedForDriver extends ContainerState {
//   final List<Container> containers;
//   final String driverId;
//   const ContainersLoadedForDriver(this.containers, this.driverId);
// }

// class ContainersLoadedForTenant extends ContainerState {
//   final List<Container> containers;
//   final String tenantId;
//   const ContainersLoadedForTenant(this.containers, this.tenantId);
// }
class ContainersLoaded extends ContainerState {
  final List<Container> containers;
  final User user;
  const ContainersLoaded(this.containers, this.user);
}

class ContainerFailure extends ContainerState {
  final String message;
  const ContainerFailure(this.message);
}
