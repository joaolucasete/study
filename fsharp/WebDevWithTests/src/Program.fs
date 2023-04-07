namespace Forum

open Forum.Server
open Microsoft.Extensions.Hosting

module Entry =
    [<EntryPoint>]
    let main _ =
        app.Run()
        0
