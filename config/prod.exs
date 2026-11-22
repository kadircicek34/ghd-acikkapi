import Config

config :mobilizon, Mobilizon.Web.Endpoint,
  http: [
    port: 4000
  ],
  url: [
    host: "mobilizon.local",
    scheme: "https",
    port: 443
  ]

# Do not print debug messages in production
config :logger, level: :info

# Load all locales in production
config :mobilizon, :cldr,
  locales: [
    "en",
    "tr"
  ]

config :ex_cldr, default_locale: "tr"

config :mobilizon, Timex.Gettext, default_locale: "tr"
