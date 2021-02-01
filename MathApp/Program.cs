using System;

namespace MathApp
{
    class Program
    {
        static void Main(string[] args)
        {
            MainMenu();
        }

        static void Add(double a, double b)
        {
            Console.WriteLine($"{a} + {b} = {a + b}");
        }

        static void Subtract(double a, double b)
        {
            Console.WriteLine($"{a} - {b} = {a - b}");
        }

        static void Multiply(double a, double b)
        {
            Console.WriteLine($"{a} * {b} = {a * b}");
        }

        static void Divide(double a, double b)
        {
            try
            {
                double result = a / b;
                Console.WriteLine($"{a} / {b} = {result}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: {ex.Message}");
            }
        }
        
        static void MainMenu()
        {
            (double, double) values = (0, 0);
            bool exitProgram = false;

            while (exitProgram != true)
            {
                Console.Write("Please input a mathematical operator or type \"exit\" to exit: ");
                string input = Console.ReadLine();

                if (input != "exit" || input.Length < 1)
                {
                    switch (input[0])
                    {
                        case ('+'):
                            values = GetInput();
                            Add(values.Item1, values.Item2);
                            break;
                        case ('-'):
                            values = GetInput();
                            Subtract(values.Item1, values.Item2);
                            break;
                        case ('*'):
                            values = GetInput();
                            Multiply(values.Item1, values.Item2);
                            break;
                        case ('/'):
                            values = GetInput();
                            Divide(values.Item1, values.Item2);
                            break;
                        default:
                            Console.WriteLine("Thanks for stopping by!");
                            exitProgram = true;
                            break;
                    }
                } 
                else
                {
                    exitProgram = true;
                }
            }
        }

        static (double, double) GetInput()
        {
            double a = 0;
            double b = 0;

            try
            {
                Console.Write("Enter a value for a: ");
                a = Convert.ToDouble(Console.ReadLine());

                Console.Write("Enter a value for b: ");
                b = Convert.ToDouble(Console.ReadLine());

                return (a, b);
            } 
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: {ex.Message}");
            }
            return GetInput();
        }
    }
}
