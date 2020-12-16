part of 'container_bloc.dart';

@immutable
abstract class ContainerState {
  const ContainerState();
}

class ContainerInitial extends ContainerState {}

class ContainerLoading extends ContainerState {}

class ContainerLoaded extends ContainerState {
  const ContainerLoaded(this.container);
  final Container container;
}

class ContainersLoaded extends ContainerState {
  final List<Container> containers;
  final ContainerStatus containerStatus;
  // ignore: sort_constructors_first
  const ContainersLoaded(this.containers, this.containerStatus);
}

class ContainerFailure extends ContainerState {
  const ContainerFailure(this.message);
  final String message;
}
