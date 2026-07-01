{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.secrets = {
    imports = [inputs.agenix.nixosModules.default];
    age.identityPaths = ["/persist/agenix-key"];
    age.secrets.anki-sync-key = {
      file = "${self}/secrets/anki-sync-key.age";
      owner = "lucab";
      mode = "0400";
    };
  };
}
