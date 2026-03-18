class PhotoEntity {
  final String id;
  final String jobId;
  final String stepId;
  final String localPath;
  final String? remoteUrl;
  final String? thumbnailUrl;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? annotation;
  final DateTime capturedAt;
  final bool isSynced;

  const PhotoEntity({
    required this.id,
    required this.jobId,
    required this.stepId,
    required this.localPath,
    this.remoteUrl,
    this.thumbnailUrl,
    this.latitude,
    this.longitude,
    this.address,
    this.annotation,
    required this.capturedAt,
    this.isSynced = false,
  });

  bool get hasGps => latitude != null && longitude != null;

  String get gpsString => hasGps
      ? '${latitude!.toStringAsFixed(6)}, ${longitude!.toStringAsFixed(6)}'
      : 'No GPS';

  /// Build an ImageKit URL with optional transformations (e.g. 'w-300,h-300')
  String? transformedUrl([String? transform]) {
    final url = remoteUrl;
    if (url == null || !url.contains('ik.imagekit.io')) return url;
    if (transform == null) return url;
    // Insert tr:transform before the file path
    final parts = url.split('/');
    final endpointEnd = parts
        .indexOf(parts.firstWhere((p) => p == 'rededge', orElse: () => ''));
    if (endpointEnd == -1) return '$url?tr=$transform';
    return '$url?tr=$transform';
  }

  PhotoEntity copyWith({
    String? remoteUrl,
    String? thumbnailUrl,
    String? address,
    String? annotation,
    bool? isSynced,
  }) {
    return PhotoEntity(
      id: id,
      jobId: jobId,
      stepId: stepId,
      localPath: localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      latitude: latitude,
      longitude: longitude,
      address: address ?? this.address,
      annotation: annotation ?? this.annotation,
      capturedAt: capturedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
