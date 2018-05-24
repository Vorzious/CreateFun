use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :create_fun_endpoint, CreateFunEndpoint.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
            node: ["node_modules/brunch/bin/brunch", "watch", "--stdin", #YipYip-Scaffold-Remove-CMS
                    cd: Path.expand("../../create_fun_cms/assets", __DIR__)], #YipYip-Scaffold-Remove-CMS
            node: ["node_modules/brunch/bin/brunch", "watch", "--stdin", #YipYip-Scaffold-Remove-WEB
                    cd: Path.expand("../../create_fun_web/assets", __DIR__)] #YipYip-Scaffold-Remove-WEB
            ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config above can be replaced with:
#
#     https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :create_fun_endpoint, CreateFunEndpoint.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/create_fun_endpoint/views/.*(ex)$},
      ~r{lib/create_fun_endpoint/templates/.*(eex)$},
      ~r{../create_fun_web/priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$}, #YipYip-Scaffold-Remove-WEB
      ~r{../create_fun_web/priv/gettext/.*(po)$}, #YipYip-Scaffold-Remove-WEB
      ~r{../create_fun_web/lib/create_fun_web/views/.*(ex)$}, #YipYip-Scaffold-Remove-WEB
      ~r{../create_fun_web/lib/create_fun_web/templates/.*(eex)$}, #YipYip-Scaffold-Remove-WEB
      ~r{../create_fun_cms/priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$}, #YipYip-Scaffold-Remove-CMS
      ~r{../create_fun_cms/priv/gettext/.*(po)$}, #YipYip-Scaffold-Remove-CMS
      ~r{../create_fun_cms/lib/create_fun_cms/views/.*(ex)$}, #YipYip-Scaffold-Remove-CMS
      ~r{../create_fun_cms/lib/create_fun_cms/templates/.*(eex)$}, #YipYip-Scaffold-Remove-CMS
    ]
  ]


