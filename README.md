## Big Data tools

### Maquinas

|  Maquina | tipo  | version  | comentarios  |   
|---|---|---|---|---|
| Spark  | standalone  | 2.2  | hadoop 2.7 + scala 2.12  |   
| HBase |  standalone | 1.2.7  |   |   
| Kafka  | standalone  | 2.12 | 3 topics  |   
|   |   |   |   |   
| HDPnn  | cluster  |  namenode | hadop 2.9.1 + Hbase 1.2. 7  |   
| HDPdn1  | cluster  | datanode1  |   |   
| HDPdn2  | cluster  |  datanode2 |   |   
|   |   |   |   |   
| Keycloak  | auth |   |   |   
| Freipa  | auth |   |   |   |



### Comandos
estado de maquinas
```
vagrant global-status
```
arrancar maquina
```
vagrant up ${Maquina}
```
connectar a CLI de maquina
```
vagrant ssh ${Maquina}
```
volver a leer los ficheros de provision
```
vagrant provision ${Maquina}
```

**Cluster** Para arrancar el cluster utilizar  **scripts/arrancarCluster.sh**

## Provision de Maquinas

En el fichero Vagranfile, esta esta parte

```
# Provision everything on the first run
#nn.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
#nn.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
nn.vm.provision "shell", path: "scripts/java_1_8.sh"
nn.vm.provision "shell", path: "scripts/installHDPnn.sh"
nn.vm.provision "shell", path: "scripts/installHBSdistributed.sh"
nn.vm.provision "shell", path: "scripts/zookeeper.sh"
# nn.vm.provision :reload
nn.vm.provision "shell", inline: "echo 'INSTALLER HDPnn: Installation complete, Oracle Linux 7 ready to use!'"
```
