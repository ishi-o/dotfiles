#!/bin/bash
JDTLS_HOME="$HOME/.local/share/jdtls"
LAUNCHER_JAR=$(find "$JDTLS_HOME/plugins" -name "org.eclipse.equinox.launcher_*.jar" | head -1)

case $(uname -s) in
    Linux*)     CONFIG_DIR="$JDTLS_HOME/config_linux" ;;
    Darwin*)    CONFIG_DIR="$JDTLS_HOME/config_mac" ;;
    *)          CONFIG_DIR="$JDTLS_HOME/config_linux" ;;
esac

WORKSPACE_DATA="$HOME/.workspace/java/$(basename "$(pwd)")"
mkdir -p "$WORKSPACE_DATA"

exec java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xms1g \
    -Xmx2G \
    -jar "$LAUNCHER_JAR" \
    -configuration "$CONFIG_DIR" \
    -data "$WORKSPACE_DATA" \
    "$@"
