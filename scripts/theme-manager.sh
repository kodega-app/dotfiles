#!/usr/bin/env bash
# ==============================================================================
# Theme Manager: Dynamic Light / Dark Appearance Switcher
# Synchronizes Catppuccin Mocha (Dark) and Catppuccin Latte (Light)
# across Kitty, Tmux, and Neovim automatically based on system appearance.
# ==============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
THEME_CACHE_FILE="$CACHE_DIR/theme"

mkdir -p "$CACHE_DIR" "$CONFIG_DIR/kitty" "$CONFIG_DIR/tmux"

# Detect system appearance: "light" or "dark"
get_system_theme() {
    # 1. Check COSMIC desktop setting if available
    local cosmic_is_dark_file="$CONFIG_DIR/cosmic/com.system76.CosmicTheme.Mode/v1/is_dark"
    if [ -f "$cosmic_is_dark_file" ]; then
        local cosmic_val
        cosmic_val=$(cat "$cosmic_is_dark_file" 2>/dev/null || echo "")
        if [ "$cosmic_val" = "false" ]; then
            echo "light"
            return
        elif [ "$cosmic_val" = "true" ]; then
            echo "dark"
            return
        fi
    fi

    # 2. Check XDG Desktop Portal via DBus (Standard across COSMIC, GNOME, KDE, Wayland)
    if command -v dbus-send &>/dev/null; then
        local dbus_val
        dbus_val=$(dbus-send --session --print-reply=literal --reply-timeout=1000 \
            --dest=org.freedesktop.portal.Desktop /org/freedesktop/portal/desktop \
            org.freedesktop.portal.Settings.Read \
            string:'org.freedesktop.appearance' string:'color-scheme' 2>/dev/null || echo "")
        if [[ "$dbus_val" == *"uint32 2"* ]]; then
            echo "light"
            return
        elif [[ "$dbus_val" == *"uint32 1"* ]]; then
            echo "dark"
            return
        fi
    fi

    # 3. Check GNOME / FreeDesktop gsettings
    if command -v gsettings &>/dev/null; then
        local scheme
        scheme=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || echo "")
        if [[ "$scheme" == *"'prefer-light'"* ]] || [[ "$scheme" == *"'light'"* ]]; then
            echo "light"
            return
        elif [[ "$scheme" == *"'prefer-dark'"* ]] || [[ "$scheme" == *"'dark'"* ]]; then
            echo "dark"
            return
        fi
    fi

    # Fallback to dark
    echo "dark"
}

# Get current cached theme ("light" or "dark")
get_current_theme() {
    if [ -f "$THEME_CACHE_FILE" ]; then
        local cached
        cached=$(cat "$THEME_CACHE_FILE" 2>/dev/null || echo "")
        if [ "$cached" = "light" ] || [ "$cached" = "dark" ]; then
            echo "$cached"
            return
        fi
    fi

    if [ -f "$CONFIG_DIR/kitty/current-theme.conf" ]; then
        if grep -q "catppuccin-latte" "$CONFIG_DIR/kitty/current-theme.conf"; then
            echo "light"
            return
        fi
    fi
    echo "dark"
}

ensure_theme_links() {
    mkdir -p "$CONFIG_DIR/kitty" "$CONFIG_DIR/tmux"
    if [ ! -e "$CONFIG_DIR/kitty/themes" ]; then
        ln -sfn "$DOTFILES_DIR/kitty/themes" "$CONFIG_DIR/kitty/themes"
    fi
    if [ ! -e "$CONFIG_DIR/tmux/themes" ]; then
        ln -sfn "$DOTFILES_DIR/tmux/themes" "$CONFIG_DIR/tmux/themes"
    fi
}

set_theme() {
    local target="$1" # "dark" or "light"
    local notify="${2:-true}" # whether to send notification
    ensure_theme_links

    # Write atomic cache file for Neovim / Tmux instant polling & inotify watcher
    local tmp_cache="${THEME_CACHE_FILE}.tmp.$$"
    echo "$target" > "$tmp_cache"
    mv -f "$tmp_cache" "$THEME_CACHE_FILE"

    if [ "$target" = "light" ]; then
        # 1. Kitty: Update theme config and signal all running instances
        echo "include themes/catppuccin-latte.conf" > "$CONFIG_DIR/kitty/current-theme.conf"
        # Notify kitty via SIGUSR1 (native reload) and remote control
        pkill -SIGUSR1 -u "$USER" -x kitty 2>/dev/null || true
        if command -v kitty &>/dev/null; then
            kitty @ set-colors -a "$CONFIG_DIR/kitty/themes/catppuccin-latte.conf" 2>/dev/null || true
        fi

        # 2. Tmux: Source latte theme across all active sessions
        if [ -n "${TMUX:-}" ] || tmux info &>/dev/null; then
            tmux source-file "$CONFIG_DIR/tmux/themes/latte.conf" 2>/dev/null || true
            tmux set-environment -g THEME "light" 2>/dev/null || true
        fi

        # 3. Notification
        if [ "$notify" = "true" ] && command -v notify-send &>/dev/null; then
            notify-send -i "preferences-desktop-theme" "Appearance" "Switched to Light Theme (Catppuccin Latte)" 2>/dev/null || true
        fi
        echo "Appearance switched to: Light (Catppuccin Latte)"
    else
        # 1. Kitty: Update theme config and signal all running instances
        echo "include themes/catppuccin-mocha.conf" > "$CONFIG_DIR/kitty/current-theme.conf"
        # Notify kitty via SIGUSR1 (native reload) and remote control
        pkill -SIGUSR1 -u "$USER" -x kitty 2>/dev/null || true
        if command -v kitty &>/dev/null; then
            kitty @ set-colors -a "$CONFIG_DIR/kitty/themes/catppuccin-mocha.conf" 2>/dev/null || true
        fi

        # 2. Tmux: Source mocha theme across all active sessions
        if [ -n "${TMUX:-}" ] || tmux info &>/dev/null; then
            tmux source-file "$CONFIG_DIR/tmux/themes/mocha.conf" 2>/dev/null || true
            tmux set-environment -g THEME "dark" 2>/dev/null || true
        fi

        # 3. Notification
        if [ "$notify" = "true" ] && command -v notify-send &>/dev/null; then
            notify-send -i "preferences-desktop-theme" "Appearance" "Switched to Dark Theme (Catppuccin Mocha)" 2>/dev/null || true
        fi
        echo "Appearance switched to: Dark (Catppuccin Mocha)"
    fi
}

toggle_theme() {
    local current
    current=$(get_current_theme)
    if [ "$current" = "dark" ]; then
        set_theme "light" "true"
    else
        set_theme "dark" "true"
    fi
}

auto_theme() {
    local notify="${1:-false}"
    local sys_theme
    sys_theme=$(get_system_theme)
    local current
    current=$(get_current_theme)

    if [ "$sys_theme" != "$current" ]; then
        set_theme "$sys_theme" "$notify"
    else
        # Ensure files and state match even if theme is already identical
        set_theme "$sys_theme" "false"
    fi
}

# Real-time background listener daemon using DBus & gsettings
listen_loop() {
    echo "Starting Theme Synchronizer listener..."
    auto_theme "false"

    # Use python if available for clean, non-blocking DBus monitoring
    if command -v python3 &>/dev/null; then
        exec python3 -u -c '
import subprocess, sys, time, os

def run_sync():
    try:
        subprocess.run(["'"$DOTFILES_DIR"'/scripts/theme-manager.sh", "auto", "true"], check=False)
    except Exception as e:
        print(f"Sync error: {e}", file=sys.stderr)

print("Theme monitor daemon active.")
# Monitor gdbus portal signals
cmd = ["gdbus", "monitor", "--session", "--dest", "org.freedesktop.portal.Desktop", "--object-path", "/org/freedesktop/portal/desktop"]
try:
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, bufsize=1)
    for line in proc.stdout:
        if "color-scheme" in line:
            time.sleep(0.1) # brief settle time
            run_sync()
except KeyboardInterrupt:
    sys.exit(0)
except Exception as e:
    print(f"Daemon fallback: {e}", file=sys.stderr)
'
    fi

    # Fallback to gsettings monitor
    if command -v gsettings &>/dev/null; then
        gsettings monitor org.gnome.desktop.interface color-scheme 2>/dev/null | while read -r _; do
            auto_theme "true"
        done
    fi
}

# Command dispatch
ACTION="${1:-auto}"
ARG2="${2:-}"

case "$ACTION" in
    dark|mocha)
        set_theme "dark" "${ARG2:-true}"
        ;;
    light|latte)
        set_theme "light" "${ARG2:-true}"
        ;;
    toggle)
        toggle_theme
        ;;
    auto)
        auto_theme "${ARG2:-false}"
        ;;
    listen|daemon)
        listen_loop
        ;;
    get)
        get_current_theme
        ;;
    system-theme)
        get_system_theme
        ;;
    status)
        echo "Current theme: $(get_current_theme) (System preference: $(get_system_theme))"
        ;;
    *)
        echo "Usage: $0 {dark|light|toggle|auto|listen|get|system-theme|status}"
        exit 1
        ;;
esac
