namespace :sessions do
  desc 'sign in'
  task sign_in: :environment do
    params = {
        email: ENV.fetch('EMAIL') {'REPLACE_ME'},
        password: ENV.fetch('PASSWORD') {'REPLACE_ME'},
    }
    client_id = ENV.fetch('CLIENT_ID') {'REPLACE_ME'}

    url = '/sessions/sign_in'
    app = App.find_by(client_id: client_id)
    nonce = Time.zone.now.to_i
    signature = Security.sign(app.client_secret, nonce, url)

    puts ''
    puts 'Sign in:'
    puts %Q(curl -v -X POST -H 'Content-Type: application/json' -H 'X-Client-Id: #{app.client_id}' -H 'X-Nonce: #{nonce}' -H 'X-Signature: #{signature}' -d '#{params.to_json}' http://0.0.0.0:3000#{url})
  end
end
