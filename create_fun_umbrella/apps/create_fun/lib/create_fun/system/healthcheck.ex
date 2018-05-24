defmodule CreateFun.System.Healthcheck do
	alias CreateFun.System.Healthcheck
	@enforce_keys [:application, :application_version]
	defstruct [
		env: Mix.env(),
		date_time: DateTime.utc_now(),
		project: :create_fun,
		project_version: CreateFun.Mixfile.project[:version],
		application: nil,
		application_version: nil,
		current_url: nil,
		host: nil
	]
end
