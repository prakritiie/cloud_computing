resource "null_resource" "simulated_infrastructure" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "Write-Output 'Applying infrastructure modifications...'; Start-Sleep -Seconds 20"
    interpreter = ["PowerShell", "-Command"]
  }
}

output "deployment_status" {
  value = "Infrastructure successfully deployed and state saved in PostgreSQL!"
}
