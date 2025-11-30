function pomodoro {
  case $1 in
    start )
      echo 'terminal-notifier -title "🍅 Pomodoro Done" -message "Starting short break…"' | at + 25 minutes &> /dev/null
      ;;
 
    break )
      echo 'terminal-notifier -title "⌛ Short Break Done" -message "Start your next Pomodoro."' | at + 5 minutes &> /dev/null
      ;;
  esac
}