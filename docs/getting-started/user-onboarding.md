# User onboarding

=== "For user"

    ## Create user

    Ask an admin to create your account, provide the following information:

    - [ ] Full name (Jam Ma)
    - [ ] Select a username (`fullstackjam`)
    - [ ] Email address (`fullstackjam@example.com`)

    ## Install companion apps

    For all users:

    - [ ] A password manager (I personally recommend [Bitwarden](https://bitwarden.com/download))

    For technical users:

    - [ ] [Docker](https://docs.docker.com/engine/install)
    - [ ] [Nix](https://nixos.org/download) and [direnv](https://direnv.net) (optional, but highly recommended)
    - [ ] [Lens](https://k8slens.dev) (optional, you can use the included `kubectl` or `k9s` command in the tools container)

=== "For admin"

    Run the following script:

    ```sh
    kanidm login --url "https://auth.fullstackjam.com" --name idm_admin
    ./scripts/onboard-user fullstackjam "Jam Ma" "fullstackjam@outlook.com"
    ```

    Let the user scan the QR code or follow the link to set up passkeys or password + TOTP.
