# show variable when run ci/cd
set -x

DockerHubUrl="localhost:5000"
Tag=$1

if [ -z "$1" ]; then
    echo "Tag NOT ALLOW empty"
    exit
fi

PrometheusImageName="$DockerHubUrl/prometheus_test:${Tag}"
GrafanaImageName="$DockerHubUrl/grafana_test:${Tag}"

# build cache
docker builder prune -f
# Stagimage
docker image prune -f

docker build prometheus -t "$PrometheusImageName" &&
docker image push "$PrometheusImageName"

docker build grafana -t "$GrafanaImageName" &&
docker image push "$GrafanaImageName"