abstract final class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String me = '/auth/me';

  // Jobs
  static const String jobs = '/jobs';

  // Users
  static const String users = '/users';
  static const String installers = '/users/installers';

  // Photos
  static const String photoUpload = '/photos/upload';
  static const String photos = '/photos';

  // Checklists
  static const String checklists = '/checklists';

  // System Types
  static const String systemTypes = '/system-types';

  // Sync
  static const String syncStatus = '/sync/status';
  static const String syncFlush = '/sync/flush';
}
