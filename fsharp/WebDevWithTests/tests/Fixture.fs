namespace Tests.Forum

open System
open System.Net.Http
open Forum.Server

module Fixture =
    let withWebApp test = task {
        let url = "http://localhost:5000/"

        do! app.StartAsync()

        use client = new HttpClient()
        client.BaseAddress <- Uri url
        do! test client

        do! app.StopAsync()
    }
