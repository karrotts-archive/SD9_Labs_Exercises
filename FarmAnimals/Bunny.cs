using System;
using System.Collections.Generic;
using System.Text;

namespace FarmAnimals
{
    public class Bunny
    {
        public string Sound { get; set; }
        public int Legs { get; set; }
        public int AttackPower { get; set; }

        public Bunny(string sound, int legs)
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
            Console.WriteLine($"The Bunny jumps really high and deals {AttackPower} jimmys!");
        }
    }
}
