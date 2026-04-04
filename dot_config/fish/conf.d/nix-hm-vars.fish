# Source home-manager session variables
if test -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    for line in (grep -E '^export ' $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh)
        set -l kv (string replace 'export ' '' $line)
        set -l key (string split '=' $kv)[1]
        set -l val (string join '=' (string split '=' $kv)[2..])
        set -l val (string trim -c '"' $val)
        set -gx $key $val
    end
end
