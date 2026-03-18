import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../storage/token_storage.dart';
import 'api_endpoints.dart';

class ApiClient {
  late final Dio dio;
  final TokenStorage _tokenStorage;

  ApiClient({
    required String baseUrl,
    required TokenStorage tokenStorage,
  }) : _tokenStorage = tokenStorage {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(_tokenStorage),
      RetryInterceptor(
        dio: dio,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 3),
          Duration(seconds: 5),
        ],
      ),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (msg) {
          // Only log in debug mode — never log tokens in release
          assert(() {
            print(msg);
            return true;
          }());
        },
      ),
    ]);
  }

  // ── Auth ──────────────────────────────────────────────
  Future<Response> login(String email, String password) {
    return dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  }) {
    return dio.post(ApiEndpoints.signup, data: {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      if (phone != null) 'phone': phone,
    });
  }

  Future<Response> getMe() {
    return dio.get(ApiEndpoints.me);
  }

  // ── Jobs ──────────────────────────────────────────────
  Future<Response> getJobs(
      {String? status, String? system, String? search, int page = 1}) {
    return dio.get(
      ApiEndpoints.jobs,
      queryParameters: {
        if (status != null) 'status': status,
        if (system != null) 'system': system,
        if (search != null) 'search': search,
        'page': page,
        'limit': 50,
      },
    );
  }

  Future<Response> getJobDetail(String jobId) {
    return dio.get('${ApiEndpoints.jobs}/$jobId');
  }

  Future<Response> createJob(Map<String, dynamic> data) {
    return dio.post(ApiEndpoints.jobs, data: data);
  }

  Future<Response> updateJob(String jobId, Map<String, dynamic> data) {
    return dio.put('${ApiEndpoints.jobs}/$jobId', data: data);
  }

  Future<Response> deleteJob(String jobId) {
    return dio.delete('${ApiEndpoints.jobs}/$jobId');
  }

  Future<Response> updateJobStatus(String jobId, String status) {
    return dio
        .patch('${ApiEndpoints.jobs}/$jobId/status', data: {'status': status});
  }

  // ── Steps ─────────────────────────────────────────────
  Future<Response> completeStep(
      String jobId, String stepIndex, Map<String, dynamic> data) {
    return dio.patch(
      '${ApiEndpoints.jobs}/$jobId/steps/$stepIndex',
      data: data,
    );
  }

  // ── Users ─────────────────────────────────────────────
  Future<Response> getInstallers() {
    return dio.get(ApiEndpoints.installers);
  }

  Future<Response> getUsers({String? role, String? search}) {
    return dio.get(ApiEndpoints.users, queryParameters: {
      if (role != null) 'role': role,
      if (search != null) 'search': search,
    });
  }

  Future<Response> createInstaller(Map<String, dynamic> data) {
    return dio.post(ApiEndpoints.users, data: data);
  }

  Future<Response> updateUser(String userId, Map<String, dynamic> data) {
    return dio.put('${ApiEndpoints.users}/$userId', data: data);
  }

  Future<Response> deleteUser(String userId) {
    return dio.delete('${ApiEndpoints.users}/$userId');
  }

  // ── Checklists ────────────────────────────────────────
  Future<Response> getChecklists() {
    return dio.get(ApiEndpoints.checklists);
  }

  Future<Response> getChecklist(String systemType) {
    return dio.get('${ApiEndpoints.checklists}/$systemType');
  }

  Future<Response> saveChecklist(Map<String, dynamic> data) {
    return dio.post(ApiEndpoints.checklists, data: data);
  }

  // ── System Types ──────────────────────────────────────
  Future<Response> getSystemTypes() {
    return dio.get(ApiEndpoints.systemTypes);
  }

  Future<Response> createSystemType(String name) {
    return dio.post(ApiEndpoints.systemTypes, data: {'name': name});
  }

  Future<Response> deleteSystemType(String id) {
    return dio.delete('${ApiEndpoints.systemTypes}/$id');
  }

  // ── Photos ────────────────────────────────────────────
  Future<Response> uploadPhoto(
      String filePath, Map<String, dynamic> metadata) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath,
          filename: filePath.split('/').last),
      ...metadata,
    });
    return dio.post(ApiEndpoints.photoUpload, data: formData);
  }

  // ── Sync ──────────────────────────────────────────────
  Future<Response> getSyncStatus() {
    return dio.get(ApiEndpoints.syncStatus);
  }

  Future<Response> triggerSync() {
    return dio.post(ApiEndpoints.syncFlush);
  }
}

class _AuthInterceptor extends Interceptor {
  final TokenStorage _storage;

  _AuthInterceptor(this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _storage.clearToken();
      // The auth state listener in the router will handle navigation
    }
    handler.next(err);
  }
}
