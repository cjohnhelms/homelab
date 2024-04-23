module "control_node" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  
  name = "control"
  tenancy = "default"
  subnet_id = "subnet-078b6e8ec245951bd"
  vpc_security_group_ids = [ "sg-0b651e5f6a9def614" ]
  ami = local.config.control_node.ami
  instance_type = local.config.control_node.type
  key_name = "macbookair.pem"
  associate_public_ip_address = true
  monitoring = false
  private_dns_name_options = {
    hostname_type = "resource-name"
    enable_resource_name_dns_a_record = true
  }

  user_data = file("./scripts/bootstrap.sh")

  root_block_device = [
    {
      volume_type = local.config.control_node.root_volume.type
      volume_size = local.config.control_node.root_volume.size
    }  
  ]
  ebs_block_device = [ for volume in try(local.config.control_node.additional_volumes, []) :
    {
      volume_type = volume.type
      volume_size = volume.size
      device_name = volume.device_name
    }
  ]
}

module "worker_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  count = local.config.worker_nodes.count

  name = "ansible${count.index + 1}"
  tenancy = "default"
  subnet_id = "subnet-078b6e8ec245951bd"
  vpc_security_group_ids = [ "sg-0b651e5f6a9def614" ]
  ami = local.config.worker_nodes.ami
  instance_type = local.config.worker_nodes.type
  key_name = "macbookair.pem"
  associate_public_ip_address = false
  monitoring = false
  private_dns_name_options = {
    hostname_type = "resource-name"
    enable_resource_name_dns_a_record = true
  }

  user_data = file("./scripts/bootstrap.sh")

  root_block_device = [
    {
      volume_type = local.config.worker_nodes.root_volume.type
      volume_size = local.config.worker_nodes.root_volume.size
    }  
  ]
  ebs_block_device = [ for volume in try(local.config.worker_nodes.additional_volumes, []) :
    {
      volume_type = volume.type
      volume_size = volume.size
      device_name = volume.device_name
    }
  ]
}
