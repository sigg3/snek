#!/bin/bash
echo "Shows surrounding map area of X (\$1) and Y (\$2) of map file (\$3)."
if [ -z "$1" -o -z "$2" -o -z "$3" ] ; then
  echo "Usage: ./$(basename $0) x y debug_map.txt" ; exit 0
else
  echo "Showing surroundings of $1 and $2"
fi

x="$1"
y="$2"
map="$3"

if [ ! -f "$map" ] ; then echo "Map file \"$3\" does not exist :/" ; exit 1 ; fi

for y_val in $((y-2)) $((y-1)) $y $((y+1)) $((y+2)); do
  for x_val in $((x-2)) $((x-1)) $x $((x+1)) $((x+2)); do
    map_tuple=$(grep -o "($x_val, $y_val): ................." "$map" | grep -o -m 1 -E '\): \([[:digit:]]{1,2}, [[:digit:]]{1,2}\)' | awk -F: '{print $2}' | tr -d " ()")
    case "$x_val" in
    $((x+2)) ) echo "  $map_tuple [$x_val,$y_val]  " ;;
    * ) echo -n "  $map_tuple [$x_val,$y_val]  "     ;;
    esac
  done
done

