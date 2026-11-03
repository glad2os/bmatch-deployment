service {
  name = "rabbitmq"
  address = "rabbitmq"
  port = 5672
  check {
    name = "rabbitmq TCP health check"
    tcp = "rabbitmq:5672"
    interval = "10s"
    timeout = "2s"
  }
}
