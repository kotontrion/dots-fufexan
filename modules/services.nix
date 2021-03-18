{ pkgs, ... }:

# server services

{
  security.acme = {
    acceptTerms = true;
    email = "fufexan@protonmail.com";
  };

  services.ddclient = {
    enable = true;
    domains = [ "@" "*" ];
    interval = "1h";
    protocol = "namecheap";
    username = "fufexan.xyz";
    use = "web, web=dynamicdns.park-your-domain.com/getip";
    server = "dynamicdns.park-your-domain.com";
    password = "";
  };

  services.nginx = {
    enable = false;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

    virtualHosts = {
      "jellyfin.fufexan.xyz" = {
        forceSSL = true;
        enableACME = true;

        locations."= /".return = "302 https://$host/web";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          extraConfig = "proxy_buffering off";
        };
        locations."= /web/".proxyPass = "http://127.0.0.1:8096/web/index.html";
        locations."/socket" = {
          proxyPass = "http://127.0.0.1:8096";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
      };
    };
  };

  services.openssh.knownHosts.kiiro.publicKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/FGSeXJhOeTVrAdnvvnFumuRliSWii6HceY879bSS8 fufexan@pm.me";

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = homesv
      netbios name = homesv
      security = user
      hosts allow = 10.0.0 localhost
      hosts deny = 0.0.0.0/0
      use sendfile = yes
      guest account = nobody
      map to guest = bad user
    '';
    shares.private = {
      path = "/media";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "mihai";
      "force group" = "users";
    };
  };

  services.samba-wsdd.enable = true;

  services.syncthing = {
    enable = true;
    guiAddress = ":8384";
  };

  services.transmission = {
    home = "/media/Torrents";
    openFirewall = true;
    settings.rpc-bind-address = "0.0.0.0";
    settings.rpc-whitelist-enables = false;
  };
}