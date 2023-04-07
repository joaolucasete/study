namespace Tests.Forum

open System
open Expecto
open Tests.Forum.Shared
open Tests.Forum.Fixture

module Server =
    [<Tests>]
    let tests =
        testList "endpoints" [
            yield! testFixtureTask withWebApp  [
                "/healthcheck returns OK", fun client -> task {
                    let url = Uri(client.BaseAddress, "/healthcheck")

                    let! response = client.GetAsync(url)

                    let expected = "OK"
                    let! got = response.Content.ReadAsStringAsync()
                    Expect.equal got expected "should return OK as response"
                }
            ]
        ]
