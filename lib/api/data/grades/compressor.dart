/// The dataset we receive has a lot of data that is pretty unnecessary,
/// so it makes more sense to strip those columns out to save on device
/// storage (which will also help with read speed later on)
abstract class DatasetCompressor {
  static String compressDataset(List<List<dynamic>> csv) {
    return "";
  }
}
