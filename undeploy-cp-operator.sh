#!/bin/bash
helm uninstall replicator -n operator
helm uninstall ksql -n operator
helm uninstall connectors -n operator
helm uninstall controlcenter -n operator
helm uninstall schemaregistry -n operator
helm uninstall kafka-oc-demo -n operator
helm uninstall zookeeper -n operator
oc delete -f scripts/openshift/customUID/scc.yaml
helm uninstall operator -n operator
oc delete project operator
