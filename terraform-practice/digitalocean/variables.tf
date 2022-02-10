variable "do_token" {}

variable cluster_name {
    default = "k8s-personal-cluster"
    type = string
}

variable cluster_region {
    default = "blr1"
    type = string
}

variable node_size {
    default = "s-2vcpu-2gb"
    type = string
}

variable node_count {
    default = 3
    type = number
}