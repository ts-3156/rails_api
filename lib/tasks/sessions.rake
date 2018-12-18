namespace :sessions do
  desc 'sign in'
  task sign_in: :environment do
    params = {
        email: ENV.fetch('EMAIL') {'REPLACE_ME'},
        password: ENV.fetch('PASSWORD') {'REPLACE_ME'},
    }

    user = User.find_for_database_authentication(email: params[:email])
    client = user.clients.active.first
    nonce = Time.zone.now.to_i
    signature = Security.sign(client.access_secret, nonce, '/sessions/sign_in')

    puts ''
    puts 'Sign in:'
    puts %Q(curl -v -X POST -H 'Content-Type: application/json' -H 'X-Access-Token: #{client.access_token}' -H 'X-Nonce: #{nonce}' -H 'X-Signature: #{signature}' -d '#{params.to_json}' http://0.0.0.0:3000/sessions/sign_in)
  end
end
