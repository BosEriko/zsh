# =============================== [ Todoist CLI ] =============================== #
TODOIST_API_URL="https://api.todoist.com/rest/v2"
TODOIST_HEADER="Authorization: Bearer $TODOIST_TOKEN"
TODOIST_LABEL="terminal"

get_label_id() {
    local label_id
    label_id=$(curl -s -H "$TODOIST_HEADER" "$TODOIST_API_URL/labels" | jq -r ".[] | select(.name==\"$TODOIST_LABEL\") | .id")

    if [ -z "$label_id" ]; then
        label_id=$(curl -s -X POST "$TODOIST_API_URL/labels" \
            -H "$TODOIST_HEADER" \
            -H "Content-Type: application/json" \
            -d "{\"name\":\"$TODOIST_LABEL\"}" | jq -r ".id")
    fi

    echo "$label_id"
}

todo() {
    local subcommand="$1"
    shift

    case "$subcommand" in
    add)
        if [ -z "$1" ]; then
            echo "Usage: todo add <task>"
            return 1
        fi
        local content="$*"
        local label_id
        label_id=$(get_label_id)
        curl -s -X POST "$TODOIST_API_URL/tasks" \
            -H "$TODOIST_HEADER" \
            -H "Content-Type: application/json" \
            -d "{\"content\":\"$content\",\"labels\":[\"$TODOIST_LABEL\"],\"due_string\":\"today\"}" >/dev/null
        echo "✅ Added task: $content"
        ;;
    show)
        curl -s -H "$TODOIST_HEADER" "$TODOIST_API_URL/tasks" |
            jq -r --arg label "$TODOIST_LABEL" '
                [ .[] | select(.labels | index($label)) ] |
                if length==0 then "No tasks ✅"
                else
                    to_entries[] | "\(.key+1). \(.value.content)"
                end'
        ;;
    check)
        if [ -z "$1" ]; then
            echo "Usage: todo check <number>"
            return 1
        fi
        local number=$1
        local task_id
        task_id=$(curl -s -H "$TODOIST_HEADER" "$TODOIST_API_URL/tasks" |
            jq -r --arg label "$TODOIST_LABEL" '
                [ .[] | select(.labels | index($label)) ] |
                if length >= $number|tonumber then .[$number|tonumber-1].id else empty end')

        if [ -z "$task_id" ]; then
            echo "❌ Invalid task number."
            return 1
        fi

        curl -s -X POST "$TODOIST_API_URL/tasks/$task_id/close" \
            -H "$TODOIST_HEADER" >/dev/null
        echo "✅ Task #$number marked as done!"
        ;;
    count)
        local count
        count=$(curl -s -H "$TODOIST_HEADER" "$TODOIST_API_URL/tasks" |
            jq -r --arg label "$TODOIST_LABEL" '[ .[] | select(.labels | index($label)) ] | length')
        echo "📌 Total tasks: $count"
        ;;
    *)
        echo "Usage: todo [add <task> | show | check <number> | count]"
        ;;
    esac
}
