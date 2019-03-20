cat /var/log/apache2/access.log | awk '/facebookexternalhit/{print $1}' | uniq | sort | uniq | sort | sed '/10.1.1.1/d' | sed '/127.0.0.1/d' | sed '/84.81.117.27/d' > blacklist
file="blacklist"
while IFS= read -r line; do
	printf 'blocking %s\n' "$line"
	iptables -A INPUT -s "$line" -j DROP
done < <(cat -- "$file")
