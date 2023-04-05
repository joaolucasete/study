namespace PizzaStore.DB;

public record Pizza
{
    public int Id { get; set; }
    public string? Name { get; set; }
}

public class PizzaDB
{
    private static List<Pizza> _pizzas = new List<Pizza>() {
        new Pizza { Id = 1, Name = "Pepperoni" },
        new Pizza { Id = 2, Name = "Hawaiian" },
        new Pizza { Id = 3, Name = "Meat Lovers" },
    };

    public static List<Pizza> GetPizzas() => _pizzas;

    public static Pizza? GetPizza(int id) => _pizzas.SingleOrDefault(p => p.Id == id);

    public static Pizza CreatePizza(Pizza pizza)
    {
        _pizzas.Add(pizza);
        return pizza;
    }

    public static Pizza UpdatePizza(Pizza update)
    {
        _pizzas = _pizzas.Select(p =>
        {
            if (p.Id == update.Id)
            {
                p.Name = update.Name;
            }
            return p;
        }).ToList();
        return update;
    }

    public static void DeletePizza(int id)
    {
        _pizzas = _pizzas.FindAll(p => p.Id != id).ToList();
    }

}