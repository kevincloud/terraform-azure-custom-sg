resource "azurerm_network_security_group" "network-sg" {
    name                = "${var.identifier}-sg"
    location            = var.location
    resource_group_name = var.res_group_name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
        Key = "DoNotDelete"
    }
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
    subnet_id                 = var.subnet_id
    network_security_group_id = azurerm_network_security_group.network-sg.id
}
