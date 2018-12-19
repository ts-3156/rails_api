namespace :registrations do
  desc 'sign up'
  task sign_up: :environment do
    params = {
        email: ENV.fetch('EMAIL') {'REPLACE_ME'},
        password: ENV.fetch('PASSWORD') {'REPLACE_ME'},
    }
    params[:password_confirmation] = params[:password]
    client_id = ENV.fetch('CLIENT_ID') {'REPLACE_ME'}

    url = '/registrations/sign_up'
    app = App.find_by(client_id: client_id)
    nonce = Time.zone.now.to_i
    signature = Security.sign(app.client_secret, nonce, url)

    puts ''
    puts 'Sign up:'
    puts %Q(curl -v -X POST -H 'Content-Type: application/json' -H 'X-Client-Id: #{app.client_id}' -H 'X-Nonce: #{nonce}' -H 'X-Signature: #{signature}' -d '#{params.to_json}' http://0.0.0.0:3000#{url})
  end
end
