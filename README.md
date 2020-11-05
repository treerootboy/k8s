# k8s

# LocalVM Start
```bash
curl -sL https://raw.githubusercontent.com/treerootboy/k8s/main/vm.sh -o vmanager
./vmanager start
```

# Setup Infrastructure
```bash
# setup faster mirror including system package repo, docker, pip, npm, composer and go
curl -sL https://raw.githubusercontent.com/treerootboy/mirrors/master/install.sh | bash -

# setup requirement software and system config
curl -sL https://raw.githubusercontent.com/treerootboy/k8s/main/setup_infrastructure.sh | bash -

```
