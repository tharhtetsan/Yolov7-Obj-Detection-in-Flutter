/// Represents the recognition output from the model
class Recognition {
  /// Index of the result
  int _id;

  /// Label of the result
  String _label;

  /// Confidence [0.0, 1.0]
  double _score;

  /// Location of bounding box rect
  ///
  /// The rectangle corresponds to the raw input image
  /// passed for inference

  Recognition(this._id, this._label, this._score);

  int get id => _id;

  String get label => _label;

  double get score => _score;

  // List<int> get location => _location;

  /// Returns bounding box rectangle corresponding to the
  /// displayed image on screen
  ///
  /// This is the actual location where rectangle is rendered on
  /// the screen

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score)';
  }
}
