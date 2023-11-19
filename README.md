# Terraform AWS EC2 Ubuntu 

## Descripción

Este proyecto crea una instancia de AWS EC2 con Terraform y se conecta a ella con SSH para manejar Ubuntu en la consola.

## Requisitos

1. Terraform
2. Cuenta de AWS
3. Ansible

## Configuración

## Variables

1. `aws_access_key` y `aws_secret_key` son las credenciales de AWS.
2. `aws_region` es la región de AWS.
3. `aws_ami` es la imagen de AWS.
4. `aws_instance_type` es el tipo de instancia de AWS.
5. `aws_key_pair` es la key_pair de AWS.

## Terraform Comandos

1. `terraform fmt` para formatear el código.
2. `terraform init` para inicializar el proyecto.
3. `terraform validate -no-color` para validar el código de Terraform.
4. `terraform plan` para ver el plan de ejecución.
5. `terraform apply -auto-approve` para aplicar los cambios en AWS.
   1. Establecer el nombre de la key_pair, siempre al final el "pem": (ej, server_pem)
6. `ssh -i "ruta del archivo pem" ubuntu@'ruta del DNS'` para conectarse a la instancia creada.
7. `Terraform destroy` para destruir la instancia creada.