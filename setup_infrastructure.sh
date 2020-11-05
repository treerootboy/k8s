# load br_netfilter mod
if [ `lsmod | grep br_netfilter -c` -eq 0 ]; then
  modprobe br_netfilter
fi

# enable net.bridge.bridge-nf-call-iptables
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# set SELinux to permissive mode to disable
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# turn off swap
swapoff -a # turnoff now
sed -i "s/\/dev\/mapper\/centos-swap/#\/dev\/mapper\/centos-swap/g" /etc/fstab # turnoff when reboot

# install k8s repo and kubeadm
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y docker kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable --now kubelet

# modify docker and kubelet cgroup driver to systemd
sed -i "s/OPTIONS='/OPTIONS='--exec-opt native.cgroupdriver=systemd/" /etc/sysconfig/docker
cat <<EOF > /etc/sysconfig/kubelet
KUBELET_EXTRA_ARGS=--cgroup-driver=systemd
EOF
