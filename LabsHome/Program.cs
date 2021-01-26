using System;

namespace LabsHome
{
    class Program
    {
        static void Main(string[] args)
        {
            int i = 0;
            try
            {
                i /= 0;

                if (i <= 0)
                {
                    Console.WriteLine("This happened");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error");
            }
        }
    }
}
