$env.PATH = ($env.PATH | prepend ['/opt/homebrew/bin' '/opt/homebrew/sbin'])
$env.PATH = ($env.PATH | prepend '~/bin')
$env.PATH = ($env.PATH | prepend '~/.cargo/bin')

# LLVM and Compiler Flags
$env.PATH = ($env.PATH | prepend '/opt/homebrew/opt/llvm/bin')
$env.CPPFLAGS = "-I/opt/homebrew/opt/llvm/include"
$env.LDFLAGS = "-L/opt/homebrew/opt/llvm/lib"

$env.PATH = ($env.PATH | prepend '~/.local/lib/kache/shims')

$env.LIBCLANG_PATH = '/opt/homebrew/opt/llvm/lib'

# GPG and SSH Agent
# tty fails without a terminal, which would abort the whole config
$env.GPG_TTY = (try { tty | str trim } catch { '' })
$env.SSH_AUTH_SOCK = $"($env.HOME)/.gnupg/S.gpg-agent.ssh"

# Launching gpg-agent (external command)
gpgconf --launch gpg-agent

if not (which fnm | is-empty) {
    ^fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
    $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD? | append {
            condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
            code: {|| ^fnm use}
        }
    )
}

$env.PATH = ($env.PATH | uniq)
