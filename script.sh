set -eo pipefail

echo "--- :package: Build job checkout directory"

pwd
ls -la


echo "--- :evergreen_tree: Build job environment"

env

echo "--- Getting info from machine"
mkdir artifacts

kubectl get secrets > artifacts/k8s_get_secrets.txt

kubectl get namespaces > artifacts/k8s_namespaces.txt

ls -alhR /var/secrets > artifacts/local_secrets_ls.txt

helm version > artifacts/helm_info.txt

helm list --all > artifacts/helm_usage.txt





