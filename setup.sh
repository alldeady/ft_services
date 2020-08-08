#!/bin/bash
red=$'\e[1;31m'
grn=$'\e[1;32m'
end=$'\e[0m'

if [[ $1 = 'del' ]]
then
	kubectl delete -f srcs/mysql.yaml
	kubectl delete -f srcs/phpmyadmin.yaml
	kubectl delete -f srcs/nginx.yaml
	kubectl delete -f srcs/wordpress.yaml
	kubectl delete -f srcs/ftps.yaml
	kubectl delete -f srcs/influxdb.yaml
	kubectl delete -f srcs/grafana.yaml
	kubectl delete -f srcs/telegraf.yaml
	printf "\nMinikube empty like my credit card :c\n"
	exit
fi

:> errlog.txt
:> log.log

minikube start	--vm-driver=virtualbox --cpus=2 --memory 4000 --addons metrics-server --extra-config=kubelet.authentication-token-webhook=true
minikube addons enable metallb >> log.log 2>>errlog.txt && sleep 2 && kubectl apply -f ./srcs/metallb.yaml >> log.log 2>>errlog.txt
minikube addons enable default-storageclass >> log.log 2>> errlog.txt
minikube addons enable storage-provisioner >> log.log 2>> errlog.txt
minikube addons enable dashboard >> log.log 2>> errlog.txt

eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)

printf "ftps: "
docker build -t ftps_alpine ./srcs/ftps > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f ./srcs/ftps.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "mysql: "
docker build -t mysql_alpine ./srcs/mysql > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f ./srcs/mysql.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "wordpress: "
docker build -t wordpress_alpine ./srcs/wordpress > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f ./srcs/wordpress.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "phpmyadmin: "
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f ./srcs/phpmyadmin.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n";
printf "influxdb: "
docker build -t influxdb_alpine srcs/influxdb > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f srcs/influxdb.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "telegraf: "
docker build -t telegraf_alpine --build-arg INCOMING=${MINIKUBE_IP} srcs/telegraf > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f srcs/telegraf.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "grafana: "
docker build -t grafana_alpine ./srcs/grafana > /dev/null 2>>errlog.txt && { printf "${grn}OK${end}\n"; kubectl apply -f ./srcs/grafana.yaml >> log.log 2>> errlog.txt; } || printf "${red}NO${end}\n"
printf "nginx: "
docker build -t nginx_alpine ./srcs/nginx > /dev/null 2>>errlog.txt && printf "${grn}OK${end}\n" || printf "${red}NO${end}\n"; kubectl apply -f ./srcs/nginx.yaml >> log.log 2>> errlog.txt

sleep 3;
WORDPRESS_IP=`kubectl get services | awk '/wordpress-svc/ {print $4}'`
PHPMYADMIN_IP=`kubectl get services | awk '/phpmyadmin-svc/ {print $4}'`
GRAFANA_IP=`kubectl get services | awk '/grafana-svc/ {print $4}'`
NGINX_IP=`kubectl get services | awk '/nginx/ {print $4}'`
printf "wordpress: $WORDPRESS_IP:5050\n"
printf "phpmyadmin: $PHPMYADMIN_IP:5000\n"
printf "grafana: $GRAFANA_IP:3000\n"
printf "nginx: $NGINX_IP\n"

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> log.log 2>> errlog.txt

sleep 3;
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/wordpress/wordpress.sql
