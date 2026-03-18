#!/usr/bin/env bash
set -euo pipefail

# Resolve repo root
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SNAPSHOT="$REPO_ROOT/.squad/restart-snapshot.json"

if [ ! -f "$SNAPSHOT" ]; then
    echo "ERROR: Snapshot not found at $SNAPSHOT"
    exit 1
fi

echo "Repo root: $REPO_ROOT"
echo "Snapshot loaded (taken: $(jq -r '.timestamp' "$SNAPSHOT"))"

# Launch services
echo ""
echo "--- Launching Services ---"
for svc in $(jq -r '.services[].name' "$SNAPSHOT"); do
    case "$svc" in
        "Squad Monitor")
            (cd "$REPO_ROOT" && dotnet run --project squad-monitor-standalone/src/SquadMonitor/SquadMonitor.csproj -c Release &)
            echo "  Started: $svc"
            ;;
        "Ralph Watch")
            (cd "$REPO_ROOT" && bash ralph-watch.ps1 &)
            echo "  Started: $svc"
            ;;
        "Dashboard UI")
            (cd "$REPO_ROOT/dashboard-ui" && npm run dev &)
            echo "  Started: $svc"
            ;;
        "CLI Tunnel Hub")
            (cd "$REPO_ROOT" && npx cli-tunnel --hub &)
            echo "  Started: $svc"
            ;;
        *)
            echo "  WARNING: Unknown service '$svc' — skipping"
            ;;
    esac
done

sleep 3

# Resume agency sessions
echo ""
echo "--- Resuming Sessions ---"
SESSION_COUNT=$(jq '.agency_sessions | length' "$SNAPSHOT" 2>/dev/null || echo 0)
if [ "$SESSION_COUNT" -gt 0 ]; then
    for i in $(seq 0 $((SESSION_COUNT - 1))); do
        SID=$(jq -r ".agency_sessions[$i].id" "$SNAPSHOT")
        SNAME=$(jq -r ".agency_sessions[$i].name" "$SNAPSHOT")
        SCWD=$(jq -r ".agency_sessions[$i].cwd" "$SNAPSHOT")
        
        # Validate UUID format
        if ! echo "$SID" | grep -qE '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'; then
            echo "  WARNING: Invalid session ID '$SID' — skipping"
            continue
        fi
        
        # Validate path
        RESOLVED_CWD="$(cd "$REPO_ROOT" && realpath -m "$SCWD" 2>/dev/null || echo "")"
        if [ -z "$RESOLVED_CWD" ] || [[ "$RESOLVED_CWD" != "$REPO_ROOT"* ]]; then
            echo "  WARNING: Session cwd '$SCWD' is outside repo root — skipping"
            continue
        fi
        
        (cd "$RESOLVED_CWD" && agency copilot --yolo --agent squad --resume="$SID" &)
        echo "  Resumed: $SNAME ($SID)"
        sleep 1
    done
else
    echo "  No agency sessions to resume."
fi

echo ""
echo "========== Recovery Complete =========="
