part of 'conectivity_bloc.dart';

abstract class ConectivityEvent {}

class ConectivityObserve extends ConectivityEvent {}

class Offline extends ConectivityEvent {}

class Online extends ConectivityEvent {}
