class Profile {
  final int id;
  final String name;
  final String urlAvatarFull;
  final String? urlAvatarMedium;
  final String? urlAvatar;
  final String? urlProfileSteam;
  final int? rankTier;
  final int? mmrEstimate;

  const Profile({
    required this.id,
    required this.name,
    required this.urlAvatarFull,
    required this.urlAvatarMedium,
    required this.urlAvatar,
    required this.urlProfileSteam,
    required this.rankTier,
    required this.mmrEstimate,
  });

  const Profile.simplified({
    required this.id,
    required this.name,
    required this.urlAvatarFull,
  })  : urlAvatarMedium = null,
        urlAvatar = null,
        urlProfileSteam = null,
        rankTier = null,
        mmrEstimate = null;
}
