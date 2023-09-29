captilaize(String a){
 final RegExp pattern = RegExp(r'([a-zA-Z]+)([0-9]+)');
  

  String result = a.replaceAllMapped(pattern, (match) {
    return '${match.group(1)} ${match.group(2)}';
  });

  return '${result[0].toUpperCase()}${result.substring(1)}';
}
//give a space between alphabtes and numver in fluter?