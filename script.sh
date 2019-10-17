set -eo pipefail

echo "--- :package: Build job checkout directory"

pwd
ls -la


echo "--- :evergreen_tree: Build job environment"

env
apk add --update openssl
echo "--- Setup kubectl"
echo "Installing kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
echo "Add Kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
echo "--- Setup kubectl done"
echo "--- Install helm"
curl -L https://git.io/get_helm.sh | bash
helm init
echo "--- Install helm done"
echo "--- Getting info from machine"
mkdir artifacts

kubectl get secrets > artifacts/k8s_get_secrets.txt || true

kubectl get namespaces > artifacts/k8s_namespaces.txt || true

ls -alhR / > artifacts/filesystem_ls.txt || true

helm version > artifacts/helm_info.txt || true

helm list --all > artifacts/helm_usage.txt || true

echo "--- Done getting info"
