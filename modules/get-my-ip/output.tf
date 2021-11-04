output "my_ip" {
  value = local.current-ip
  sensitive = true
}
