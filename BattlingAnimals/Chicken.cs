using System;
using System.Collections.Generic;
using System.Text;

namespace BattlingAnimals
{
    class Chicken
    {
        public int Health { get; set; }
        public int Defense { get; set; }
        public int Attack { get; set; }
        public string Sound { get; set; }

        public Chicken(int health, int defense, int attack, string sound)
        {
            Health = health;
            Defense = defense;
            Attack = attack;
            Sound = sound;
        }

        public void TakeDamage(int damage)
        {
            if (Health > 0)
            {
                double totalDefense = 100 / (double)Defense;
                int totalDamage = (int)(totalDefense * damage);

                Console.WriteLine($"The chicken has taken {totalDamage} damage!");
                Health -= totalDamage;
            }
        }

        public void DisplayHealth()
        {
            Health = Health <= 0 ? 0 : Health;
            if (Health > 0)
            {
                Console.WriteLine($"The Chicken currently has {Health} health!");
            }
            else
            {
                Console.WriteLine("Oof. Looks like the chicken died..");
            }
        }

        public void PlaySound()
        {
            Console.WriteLine($"The Chicken says: {Sound}!");
        }

        public void IncreaseHealth(int amount)
        {
            Health += amount;
        }
    }
}
