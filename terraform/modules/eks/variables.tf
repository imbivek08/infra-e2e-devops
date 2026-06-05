variable "env" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "eks_nodes_sg_id" {
  type = string
}

variable "k8s_version" {
  type    = string
  default = "1.29"
}

variable "node_instance_type" {
  type = string
}

variable "node_desired" {
  type = number
}

variable "node_min" {
  type = number
}

variable "node_max" {
  type = number
}
