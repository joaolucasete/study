using System.Collections.Generic;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () =>
{
    var randomText = new List<string> {
        "Hello World",
        "How are you?",
        "I'm fine, thank you.",
        "And you?",
        "I'm fine too."
    };
    return randomText[new Random().Next(0, randomText.Count)];
});

app.Run();
