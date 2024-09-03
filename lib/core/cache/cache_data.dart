import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

final cacheManager = CacheManager(
  Config(
    'my_cache_key',
    stalePeriod: Duration(days: 7),
    maxNrOfCacheObjects: 20,
    repo: JsonCacheInfoRepository(databaseName: 'my_cache_info.db'),
    fileService: HttpFileService(),
  ),
);

