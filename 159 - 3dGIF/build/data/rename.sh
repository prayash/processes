for i in *.gif; do
  new=$(printf "%01d.jpg" "$a")
    mv -- "$i" "$new"
      let a=a+1
done
