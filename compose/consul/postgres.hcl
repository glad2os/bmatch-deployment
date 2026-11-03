service {
  name = "postgres"
  address = "postgres"
  port = 5432
  check {
    name = "postgres TCP health check"
    tcp = "postgres:5432"
    interval = "10s"
    timeout = "2s"
  }
}
