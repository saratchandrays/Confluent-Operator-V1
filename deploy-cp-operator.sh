#!/bin/bash
oc new-project operator
helm install operator ./confluent-operator -f values.yaml --namespace operator --set operator.enabled=true
oc create -f scripts/openshift/customUID/scc.yaml
oc adm policy add-scc-to-user privileged -z default -n operator
helm install zookeeper ./confluent-operator -f values.yaml --namespace operator  --set zookeeper.enabled=true
helm install kafka-oc-demo ./confluent-operator -f values.yaml --namespace operator --set kafka.enabled=true 
helm install schemaregistry ./confluent-operator -f values.yaml --namespace operator --set schemaregistry.enabled=true
helm install -f values.yaml controlcenter --namespace operator --set controlcenter.enabled=true ./confluent-operator
helm install -f values.yaml connectors --namespace operator --set connect.enabled=true ./confluent-operator
helm install -f values.yaml ksql --namespace operator --set ksql.enabled=true ./confluent-operator
helm install -f values.yaml replicator --namespace operator --set replicator.enabled=true ./confluent-operator
