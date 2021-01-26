using System;

namespace LAB3C
{
    class Program
    {
        static void Main(string[] args)
        {
            TutitonCaluclator();
            FeetToInches(12.5d);
            Max();
        }

        static void TutitonCaluclator ()
        {
            double tuition = 6000.0d;

            for (int i = 1; i <= 5; i++)
            {
                tuition += tuition * .02;
                Console.WriteLine($"For year {i} your tuition will be {tuition}");
            }
        }

        static void FeetToInches(double feet)
        {
            double inches = feet * 12.0d;
            Console.WriteLine($"{feet} feet is {inches} inches");
        }

        static void Max()
        {
            Console.WriteLine("Enter a value for a: ");
            int a = int.Parse(Console.ReadLine());
            Console.WriteLine("Enter a value for b: ");
            int b = int.Parse(Console.ReadLine());
            Console.WriteLine(a > b ? $"{a} greater than {b}" : $"{b} greater than {a}");
        }
    }
}
