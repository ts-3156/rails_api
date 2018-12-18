# API only Rails demo

```ruby
user = User.create(email: 'email@example.com', name: 'John', password: 'pass')
app = App.create(user: user, name: "#{user.name}'s app")
client = Client.create(app: app, user: uuser)
```

