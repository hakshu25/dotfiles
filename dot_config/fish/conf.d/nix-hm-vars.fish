# Source home-manager session variables.
#
# hm-session-vars.sh is a POSIX script meant to be `source`d by bash/sh, so its
# values may contain `$VAR` / `${VAR:+sep}` expansions. fish can't evaluate
# those, so we handle the known terminfo vars explicitly and skip anything else
# that still holds an unexpanded reference (otherwise fish would store e.g.
# TERM as the literal string "$TERM", breaking terminfo lookup and making less
# and git warn "terminal is not fully functional").
if test -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    for line in (grep -E '^export ' $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh)
        set -l kv (string replace 'export ' '' $line)
        set -l key (string split '=' $kv)[1]
        set -l val (string join '=' (string split '=' $kv)[2..])
        set -l val (string trim -c '"' $val)

        switch $key
            case TERM
                # `export TERM="$TERM"` is a self-referential no-op; the
                # terminal emulator already sets TERM. Never clobber it.
                continue
            case TERMINFO_DIRS
                # Prepend the nix terminfo dir, keep any existing dirs, then
                # append the system dir.
                set -l dirs $HOME/.nix-profile/share/terminfo
                test -n "$TERMINFO_DIRS"; and set -a dirs (string split ':' $TERMINFO_DIRS)
                set -a dirs /usr/share/terminfo
                set -gx TERMINFO_DIRS (string join ':' $dirs)
                continue
        end

        # fish can't expand remaining POSIX `$...` references; skip rather than
        # store a broken literal value.
        if string match -q '*$*' -- $val
            continue
        end
        set -gx $key $val
    end
end
