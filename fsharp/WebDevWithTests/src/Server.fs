namespace Forum

open Giraffe
open Giraffe.EndpointRouting
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Hosting
open Microsoft.AspNetCore.Http
open Microsoft.Extensions.Hosting
open System


module Server = 
  let healthcheck: HttpHandler =
    fun (next: HttpFunc) (ctx: HttpContext) ->
      text "OK" next ctx

  let endpoints = [
    GET [
      route "/healthcheck" healthcheck
    ]
  ]
  
  let configureApp (app: IApplicationBuilder) =
    app
        .UseRouting()
        .UseEndpoints(fun e -> e.MapGiraffeEndpoints(endpoints))
    |> ignore

  let app =
      let builder =
          Host.CreateDefaultBuilder()
              .ConfigureWebHostDefaults(fun webHost ->
                  webHost.Configure(configureApp) |> ignore)

      builder.Build()


