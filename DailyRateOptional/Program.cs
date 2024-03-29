﻿using System;

namespace DailyRateOptional
{
    class Program
    {
        static void Main(string[] args)
        {
            (new Program()).run();
        }

        public void run()
        {
            double fee = calculateFee(theDailyRate: 375.0);
            Console.WriteLine($"Fee is {fee}");
        }

        private void writeFee(double v) => Console.WriteLine($"The consultant's fee is: {v * 1.1}");
        private double calculateFee(double theDailyRate = 500.0, int noOfDays = 1)
        {
            Console.WriteLine("calculateFee using two optional parameters");
            return theDailyRate * noOfDays;
        }

        private double calculateFee(double dailyRate = 500.0)
        {
            Console.WriteLine("calculateFee using one optional parameter");
            int defaultNoOfDays = 1;
            return dailyRate * defaultNoOfDays;
        }

        private double calculateFee()
        {
            Console.WriteLine("calculateFee using hardcoded values");
            double defaultDailyRate = 400.0;
            int defaultNoOfDays = 1;
            return defaultDailyRate * defaultNoOfDays;
        }
    }
}
