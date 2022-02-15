import 'dart:io';

// android or fuchsia or ios
final isMobile = Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;

// windows or linux or macos
final isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
