/// The type of animation when navigating from one route to other.
enum AnimationType {
  /// New page pushed on the stack with no animations.
  none,

  /// New page is pushed on the stack fading in, and poped out of the stack
  /// fading out.
  fade,

  /// New page is pushed on the stack fading and scaling in,
  /// and poped out of the stack fading and scaling out.
  scale,

  /// New page is pushed on the stack droping down from the top of the page
  slideDown,

  /// New Page is pushed on the stack moving upwards on the stack
  slideUp,

  /// New Page is pushed on the statck sliding towards the start of the page
  /// based on [Directionality] of either `rtl` or `ltr`
  slideToStart,

  /// New Page is pushed on the statck sliding towards the end of the page
  /// based on [Directionality] of either `rtl` or `ltr`
  slideToEnd,
}
