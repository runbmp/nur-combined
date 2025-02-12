{ config, pkgs, nixosConfig, ... }:
{
  sops.secrets.github_token = {
    path = "${config.xdg.configHome}/git/credentials";
  };

  programs.git = {
    enable = true;
    userName = "slaier";
    userEmail = "slaier@users.noreply.github.com";
    diff-so-fancy = {
      enable = true;
    };
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      merge.ff = "only";
      pull.rebase = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = ''${pkgs.writeText "allowedSigners.txt"
          ''${config.programs.git.userEmail} ${nixosConfig.programs.ssh.knownHosts."local.local".publicKey}''}'';
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519";
      commit.gpgsign = true;
    };

    ignores = [
      ".cache"
      ".direnv"
    ];

    aliases = {
      d = "diff";
      dc = "diff --cached";
      ds = "diff --staged";
      r = "restore";
      rs = "restore --staged";
      st = "status -sb";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
