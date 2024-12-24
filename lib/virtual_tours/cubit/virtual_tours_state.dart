// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class VirtualToursState extends Equatable {
  const VirtualToursState({
    this.isTourEnabled = false,
    this.virtualTours = const [],
  });

  final bool isTourEnabled;
  final List<String> virtualTours;
  @override
  List<Object> get props => [
        isTourEnabled,
        virtualTours,
      ];

  VirtualToursState copyWith({
    bool? isTourEnabled,
    List<String>? virtualTours,
  }) {
    return VirtualToursState(
      isTourEnabled: isTourEnabled ?? this.isTourEnabled,
      virtualTours: virtualTours ?? this.virtualTours,
    );
  }
}
