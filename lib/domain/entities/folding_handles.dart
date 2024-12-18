class FoldingHandles {
  bool onUsersLeftSide;
  bool onUsersRightSide;

  FoldingHandles({
    required this.onUsersLeftSide,
    required this.onUsersRightSide,
  });

  factory FoldingHandles.fromJson(Map<String, dynamic> json) => FoldingHandles(
    onUsersLeftSide: json["onUsersLeftSide"],
    onUsersRightSide: json["onUsersRightSide"],
  );
}