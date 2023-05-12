set :output, {:error => 'log/cron_error_log.log', :standard => 'log/cron_log.log'}

every 1.minute do
  runner 'Rental.send_rental_expiration_notification'
end