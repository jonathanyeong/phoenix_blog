# Personal blog of Jonathan Yeong

This is my personal blog written in phoenix. It (will) contain an admin dashboard to write and manage posts.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Change `config/dev.exs` database values to your local setup
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Run seeds to add the admin user `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Admin dashboard

User authentication was generated through the `phx_gen_auth` package.

Assuming seeds have been run, you should navigate to [`localhost:4000/admin`](http://localhost:4000/admin) which will direct you to login.

The user to login is:

```
test@example.com
password1234
```

After logging in you should be taken to the dashboard to create your posts.

Note: Registration has been removed from the site since it assumes there will only ever be one user making posts.