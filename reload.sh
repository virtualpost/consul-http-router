ps |grep -v grep |grep "nginx: worker" > /dev/null
rc=$?

if [[ $rc == 0 ]]; then
 	nginx -s reload
else
	echo "Starting nginx"
	nginx
fi
