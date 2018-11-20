kubectl常用命令
===================

- kubectl get nodes
- kubectl describe node test-kube
- kubectl get svc
- kubectl get rc


- kubectl create -f xxx.yaml （不建议使用，无法更新，必须先delete）
- kubectl apply -f xxx.yaml （创建+更新，可以重复使用）

