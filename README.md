# Feedcram

This is a very quick and dirty RSS/Atom reader built using Rails. Multi-user
support is built-in, however it's largely untested in production environments
and I'd recommend that you not use this mode yet. Styling is provided by
Twitter Bootstrap so the layout is reponsive and works well on mobile devices.

## Running the app

You'll need to configure the database and the settings in the config directory
(in the files named database.yml and settings.yml). The database configuration
uses environment variables that can be set externally before starting the
application

Once you have things configured, install the necessary gems and boot the app
locally as you would any other Rails app.

```shell
bundle
bin/rails server
```

If you run this in production I'd recommend using Unicorn:

```shell
bin/unicorn
```

## Updating Feeds

A simple Rake task is provided to update all feeds. Currently there are no
checks for IMS or ETag requests, so be gentle and run it at most every hour or
more.

```shell
bin/rake feeds:update
```

## Contributing

Feel free to make any contributions; follow the usual GitHub flow of a pull
request, writing any relevant tests and making sure that the existing specs
pass.

