using System.Collections.Generic;
using PizzaStore.DB;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "PizzaStore API", Description = "Making the Pizza you love", Version = "v1" });
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "PizzaStore API v1"));

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

app.MapGet("/pizzas", () => PizzaDB.GetPizzas());
app.MapGet("/pizzas/{id}", (int id) => PizzaDB.GetPizza(id));
app.MapPost("/pizzas", (Pizza pizza) => PizzaDB.CreatePizza(pizza));
app.MapPut("/pizzas", (Pizza pizza) => PizzaDB.UpdatePizza(pizza));
app.MapDelete("/pizzas/{id}", (int id) => PizzaDB.DeletePizza(id));

app.Run();
