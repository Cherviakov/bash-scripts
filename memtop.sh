{
  {
    echo "_PID_ _NAME_ _Mem_"
    for i in /proc/[0-9]*
      do
        echo -e "${i##*/}\t$(<$i/comm)\t$(pmap -d "${i##*/}" | tail -1 | (read a b c mem;echo $mem))"
      done |\
      sort -nr -k3 |\
      head -$((${LINES:-23} - 3))
  } | \
  column -t
} 2>/dev/null
