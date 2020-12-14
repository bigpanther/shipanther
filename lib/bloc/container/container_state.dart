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
  const ContainersLoaded(this.containers);
  final List<Container> containers;
}

class ContainerFailure extends ContainerState {
  const ContainerFailure(this.message);
  final String message;
}
