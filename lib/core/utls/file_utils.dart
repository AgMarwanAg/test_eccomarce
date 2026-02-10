import 'dart:io';

/// Enum representing various file types.
enum FileType { image, video, document, pdf, other }

/// Utility class for file-related operations.
class FileUtils {
  /// A map of file extensions to their corresponding [FileType].
  static final Map<String, FileType> extensionMap = {
    'jpg': FileType.image,
    'jpeg': FileType.image,
    'png': FileType.image,
    'mp4': FileType.video,
    'doc': FileType.document,
    'docx': FileType.document,
    'pdf': FileType.pdf,
  };

  /// List of image file extensions supported.
  static const List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
    'svg',
    'bmp',
    'gif',
    'tiff',
    'heic',
  ];

  /// Determines the [FileType] based on the file's extension.
  ///
  /// Returns:
  /// - A [FileType] value corresponding to the file's extension.
  /// - [FileType.other] if the extension is not recognized.
  ///
  /// [fileName]: The name of the file including its extension.
  static FileType getFileType(String fileName) {
    // Extract the file extension and convert it to lowercase.
    final ext = fileName.split('.').last.toLowerCase();

    // Look up the file type in the extension map.
    return extensionMap[ext] ?? FileType.other;
  }

  /// Gets the size of a file in bytes.
  ///
  /// Throws:
  /// - [Exception] if the file does not exist.
  ///
  /// [filePath]: The path to the file.
  ///
  /// Returns:
  /// - An integer representing the file size in bytes.
  static Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      return await file.length();
    } else {
      throw Exception("File not found: $filePath");
    }
  }

  /// Gets the file size in a human-readable format.
  ///
  /// [filePath]: The path to the file.
  ///
  /// Returns:
  /// - A string representing the file size in a formatted style (e.g., KB, MB, GB).
  static Future<String> getFormattedFileSize(String filePath) async {
    final bytes = await getFileSize(filePath);
    return _formatBytes(bytes);
  }

  /// Formats a byte value into a human-readable string.
  ///
  /// [bytes]: The size in bytes.
  /// [decimals]: Number of decimal places to display (default is 2).
  ///
  /// Returns:
  /// - A string representing the formatted size (e.g., `12.34 KB`).
  static String _formatBytes(int bytes, [int decimals = 2]) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var i = 0;

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
