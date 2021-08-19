# Kubespray PoC
Deploy kubespray as a Service (PoC).

#### First steps
```bash
git clone git@github.com:kubernetes-sigs/kubespray.git
cd kubespray/
git checkout v2.16.0 # Kubespray version
export CLUSTER=cluster01
```
## Create the infra
In order to create a production ready cluster infraestructure, we can take advantage from [kubespray terraform section](https://github.com/kubernetes-sigs/kubespray/tree/master/contrib/terraform).

### Openstack infra with kubespray
```bash
# Create custom inventory
cp -LRp contrib/terraform/openstack/sample-inventory inventory/$CLUSTER
cd inventory/$CLUSTER
ln -s ../../contrib/terraform/openstack/hosts
ln -s ../../contrib


# EDIT the cluster.tfvars file as described in:
#   https://github.com/kubernetes-sigs/kubespray/blob/master/contrib/terraform/openstack/README.md
vim cluster.tfvars
```
> TIP: Check [this example](./README.d/kubespray-openstack-diff-example.md).

```bash
# Prepare OpenStack cloud config:
#   https://github.com/kubernetes-sigs/kubespray/blob/master/contrib/terraform/openstack/README.md#openstack-access-and-credentials
export OS_CLOUD=kubespray

# Deploy the infra (tested with Terraform v0.13.7)
terraform init ./contrib/terraform/openstack/
terraform apply -var-file=cluster.tfvars ./contrib/terraform/openstack/
```

```bash
# Check reachability
export ANSIBLE_HOST_KEY_CHECKING=False
ansible all -i ./hosts -m ping
```

## Bootstrap kubespray cluster
```bash
ansible-playbook -b -i ./hosts ../../cluster.yml
```
