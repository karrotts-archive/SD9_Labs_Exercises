using System;
using System.Collections.Generic;
using System.Text;

namespace FarmAnimals
{
    class Chicken
    {
        public string Sound { get; set; }
        public int Legs { get; set; }
        public int AttackPower { get; set; }

        public Chicken(string sound, int legs)
        {
            Sound = sound;
            Legs = legs;
        }

        public void Speak()
        {
            Console.WriteLine(Sound);
        }

        public void AmountOfLegs()
        {
            Console.WriteLine(Sound);
        }

        public int GetAttackPower()
        {
            return AttackPower;
        }

        public void Attack()
        {
            Console.WriteLine($"The Chicken clucks and deals {AttackPower} damage! Oh No!");
        }
    }
}
