

///[Please_note] that when using this class with [CachedNetworkImage]
///it will cause a lot of unnecessary caching of images.
///This class is intended for testing purposes only.
///
///
///[DummyImage] =dummy network image
///This class is used to create dummy network images
///for test purposes
///
class DummyImage {
 
  ///returns URL for random image with given width and height
  ///default values are 500x300
  ///[w] width can not be greater than 5000
  ///[h] height can not be greater than 5000
  static String randImg({w = 500, h = 300}) {
    if (w > 5000) w = 5000;
    if (h > 5000) h = 5000;
    return 'https://picsum.photos/$w/$h';
  }

  ///returns URL for random image with given width and height
  ///default values are 500x300
  ///[w] width can not be greater than 2000
  ///[h] height can not be greater than 2000
  // static placeholderImage({int w = 500,int h = 300}) {
  //   if (w > 2000) w = 2000;
  //   if (h > 2000) h = 2000;
  //   return 'https://via.placeholder.com/${w}x$h';
  // }
  static String placeholderImage()=>"https://picsum.photos/250/250";
  ///returns URL for random image with given width and height
  ///default values are 500x300
  ///[w] width can not be greater than 2000
  ///[h] height can not be greater than 2000
  ///[t] text for the image
  ///[bgColor] background color
  ///[txtColor] text color
  // static customImg({w = 500, h = 300, Color txtColor = Colors.white, Color bgColor = Colors.black, t = 'data'}) {
  //   if (w > 2000) w = 2000;
  //   if (h > 2000) h = 2000;
  //   String tc = _colorToHex(txtColor);
  //   String bgc = _colorToHex(bgColor);
  //   // String bgc = _colorToHex(bgColor);
  //   return 'https://dummyimage.com/300x200/$bgc/$tc&text=$t';
  // }
  // ///converts color to hex format 
  // static String _colorToHex(Color color) {
  //   return (color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
  // }
}
