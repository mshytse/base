data "http" "ipv6_only" {
  url = "https://ipv6.google.com"
}
output "status" {
  value = data.http.ipv6_only.status_code
}