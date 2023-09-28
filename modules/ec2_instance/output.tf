
# TODO: Make it sensetive
output "ssh_private_key_pem" {
  value = tls_private_key._.private_key_pem
}

output "ssh_public_key_pem" {
  value = tls_private_key._.public_key_pem
}