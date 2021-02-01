using System;

namespace HW_4D
{
    class Program
    {
        static void Main(string[] args)
        {
            //Compound Assignment and Iteration

            //1. *=, /=, and += are examples of compound assignment operators.Is != a compound assignment operator?
            // No. != is not a compound assignment operator since is does not perfom a function on an operation. It is a conditional.

            //2. If you want your loop to run at least once, which looping construct should you use?
            // You would use the do while loop.

            //3. How does the continue keyword differ between a for loop and a do or while loop ?
            // The continue keyword differs because if you continue in a while loop or do/while loop, control immediately jumps to the Boolean expression. The For loop goes to the next iteration.



            //Apply
            //Methods, Scope, and Conditionals
            //Write an expression - bodied method that multiplies an int parameter by itself and returns the result.
            int Multiply(int i) => i * i;

            //Write a normal method that multiplies an int parameter by itself and returns the result if the parameter’s initial value is greater than 0.Otherwise, return 0.
            int Multiply2(int i)
            {
                if (i <= 0) return 0;
                return i * i;
            }
        }
    }
}
