module "s3" {
  source = "../container"
  name   = "outline-s3"
  image  = "minio/minio"

  networks = ["${docker_network.outline.id}"]

  volumes = [
    {
      container_path = "/data"
      host_path      = "/mnt/xwing/data/outline/minio"
    },
    {
      container_path = "/root/.minio"
      host_path      = "/mnt/xwing/config/outline/minio"
    },
  ]

  env = [
    "MINIO_ACCESS_KEY=${local.minio_access_key}",
    "MINIO_SECRET_KEY=${local.minio_secret_key}",
    "MINIO_BROWSER=off",
  ]

  command = ["server", "/data"]
}

# docker run -p 9000:9000 --name minio1 \
#   -e "MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" \
#   -e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
#   -v /mnt/data:/data \
#   -v /mnt/config:/root/.minio \
#   minio/minio server /data

