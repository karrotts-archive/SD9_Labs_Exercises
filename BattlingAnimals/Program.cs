using System;

namespace BattlingAnimals
{
    class Program
    {
        static void Main(string[] args)
        {
            Bunny Joe = new Bunny(10, 20, 50, "nibble nibble");
            Horse Morse = new Horse(20, 20, 10, "naaaaaay");
            Chicken Dinner = new Chicken(15, 10, 20, "cluck");
            Cow Bell = new Cow(30, 10, 10, "eat more chicken");

            Console.WriteLine("Welcome to the farm where all the animals hate each other...\n");

            Console.WriteLine("If we take a look over here Bunny Joe is fighting the Horse Morse.");
            Console.WriteLine("Looks like the horse is about to attack!\n");

            Joe.PlaySound();
            Joe.TakeDamage(Morse.Attack);
            Morse.PlaySound();
            Joe.DisplayHealth();

            Console.WriteLine("\nDont worry I have a special potion that heals these angry animals.");
            Console.WriteLine("Here you go bunny!");
            Joe.PlaySound();
            Joe.IncreaseHealth(10);
            Joe.DisplayHealth();

            Console.WriteLine("\nNow go attack!");
            Console.WriteLine("*The bunny leaps towards the large horse*");
            Morse.DisplayHealth();
            Morse.PlaySound();
            Joe.PlaySound();
            Morse.TakeDamage(Joe.Attack);
            Morse.DisplayHealth();

            Console.WriteLine("\nLooks like they are getting along great. Lets move on..");
            Console.WriteLine("Lets check up on my favorite chicken Dinner, and my favorite cow Bell.");
            Console.WriteLine("\nOh no... they are attacking each other too. The chicken is about to attack!\n");
            Dinner.PlaySound();
            Bell.PlaySound();
            Bell.TakeDamage(Dinner.Attack);
            Bell.DisplayHealth();

            Console.WriteLine("\nOh... I was not expecting that. ");
            Console.WriteLine("Looks like I have some cleaning up to do. I hope you had a great time at my farm.");
            Console.WriteLine("(please dont report this farm to the authorities)");

        }
    }
}
