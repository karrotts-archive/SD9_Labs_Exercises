using System;

namespace Factorial
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Please enter a positive integer: ");
            string inputValue = Console.ReadLine();
            long factorialValue = CalculateFactorial(inputValue);
            Console.WriteLine($"Factorial({inputValue}) is {factorialValue}");
        }

        static long CalculateFactorial(string input)
        {
            int inputValue = int.Parse(input);
            long factorial(int dataValue)
            {
                if (dataValue == 1)
                {
                    return 1;
                }
                else
                {
                    return dataValue * factorial(dataValue - 1);
                }
            }
            long factorialValue = factorial(inputValue);
            return factorialValue;
        }
    }
}
