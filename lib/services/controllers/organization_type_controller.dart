import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/shared/utils/type_defs.dart';

final organizationTypeControllerProvider =
    AsyncNotifierProvider<OrganizationTypeController, OrganizationType>(
  OrganizationTypeController.new,
);

class OrganizationTypeController extends AsyncNotifier<OrganizationType> {
  @override
  FutureOr<OrganizationType> build() => OrganizationType.transportCompany;

  OrganizationType get getSelectedVenue => state.value!;

  setOrganizationType({required OrganizationType organizationType}) =>
      state = AsyncValue.data(organizationType);

  List<OrganizationType> get getAllOrganizationTypes => OrganizationType.values;
}
