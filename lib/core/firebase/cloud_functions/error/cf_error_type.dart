enum CFErrorType {
  ok('ok'),
  cancelled('cancelled'),
  unknown('unknown'),
  invalid_argument('invalid-argument'),
  deadline_exceeded('deadline-exceeded'),
  not_found('not-found'),
  already_exists('already-exists'),
  permission_denied('permission-denied'),
  resource_exhausted('resource-exhausted'),
  failed_precondition('failed-precondition'),
  aborted('aborted'),
  out_of_range('out-of-range'),
  unimplemented('unimplemented'),
  internal('internal'),
  unavailable('unavailable'),
  data_loss('data-loss'),
  unauthenticated('unauthenticated');

  final String value;
  const CFErrorType(this.value);

  static final Map<String, CFErrorType> _map = {
    for (var e in CFErrorType.values) e.value: e,
  };

  static CFErrorType? fromString(String value) => _map[value];
}
