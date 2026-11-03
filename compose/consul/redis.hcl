service {
  name = "redis"
  address = "redis"
  port = 6379
  check {
    name = "redis TCP health check"
    tcp = "redis:6379"
    interval = "10s"
    timeout = "2s"
  }
}
