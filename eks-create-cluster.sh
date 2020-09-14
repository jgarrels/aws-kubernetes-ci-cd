eksctl create cluster \
--name capstone \
--version 1.14 \
--nodegroup-name servers \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3 \
--node-ami auto