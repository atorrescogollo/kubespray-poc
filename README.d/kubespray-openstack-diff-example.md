```diff
--- ./contrib/terraform/openstack/sample-inventory/cluster.tfvars       2021-08-19 19:30:51.714264863 +0200
+++ cluster.tfvars      2021-08-19 20:03:09.111948821 +0200
@@ -1,5 +1,5 @@
 # your Kubernetes cluster name here
-cluster_name = "i-didnt-read-the-docs"
+cluster_name = "cluster01"

 # list of availability zones available in your OpenStack cluster
 #az_list = ["nova"]
@@ -8,10 +8,10 @@
 public_key_path = "~/.ssh/id_rsa.pub"

 # image to use for bastion, masters, standalone etcd instances, and nodes
-image = "<image name>"
+image = "ubuntu20_04"

 # user on the node (ex. core on Container Linux, ubuntu on Ubuntu, etc.)
-ssh_user = "<cloud-provisioned user>"
+ssh_user = "ubuntu"

 # 0|1 bastion nodes
 number_of_bastions = 0
@@ -22,7 +22,7 @@
 number_of_etcd = 0

 # masters
-number_of_k8s_masters = 1
+number_of_k8s_masters = 3

 number_of_k8s_masters_no_etcd = 0

@@ -30,14 +30,14 @@

 number_of_k8s_masters_no_floating_ip_no_etcd = 0

-flavor_k8s_master = "<UUID>"
+flavor_k8s_master = "7fcec..."

 # nodes
-number_of_k8s_nodes = 2
+number_of_k8s_nodes = 3

-number_of_k8s_nodes_no_floating_ip = 4
+number_of_k8s_nodes_no_floating_ip = 0

-#flavor_k8s_node = "<UUID>"
+flavor_k8s_node = "7fcec..."

 # GlusterFS
 # either 0 or more than one
@@ -50,12 +50,25 @@
 #flavor_gfs_node = "<UUID>"

 # networking
-network_name = "<network>"
+network_name = "cluster01-int"

-external_net = "<UUID>"
+external_net = "7c5aa2..."

-subnet_cidr = "<cidr>"
+subnet_cidr = "172.20.20.0/24"

-floatingip_pool = "<pool>"
+floatingip_pool = "ext_net"

 bastion_allowed_remote_ips = ["0.0.0.0/0"]
+
+master_allowed_ports = [
+  { "protocol" = "tcp", "port_range_min" = 443, "port_range_max" = 443, "remote_ip_prefix" = "0.0.0.0/0"},
+  { "protocol" = "tcp", "port_range_min" = 22,  "port_range_max" = 22,  "remote_ip_prefix" = "0.0.0.0/0"},
+  { "protocol" = "icmp", "port_range_min" = 0,  "port_range_max" = 0,  "remote_ip_prefix" = "0.0.0.0/0"}
+]
+worker_allowed_ports = [
+  { "protocol" = "tcp", "port_range_min" = 443, "port_range_max" = 443, "remote_ip_prefix" = "0.0.0.0/0"},
+  { "protocol" = "tcp", "port_range_min" = 22,  "port_range_max" = 22,  "remote_ip_prefix" = "0.0.0.0/0"},
+  { "protocol" = "icmp", "port_range_min" = 0,  "port_range_max" = 0,  "remote_ip_prefix" = "0.0.0.0/0"}
+]
+
+use_access_ip = 0
```
