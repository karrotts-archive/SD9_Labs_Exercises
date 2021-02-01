using System;
using System.Collections.Generic;
using System.Text;

namespace BattlingAnimals
{
    public class Cow
    {
        public int Health { get; set; }
        public int Defense { get; set; }
        public int Attack { get; set; }
        public string Sound { get; set; }

        public Cow (int health, int defense, int attack, string sound)
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

                Health -= totalDamage;
            }
        }

        public void DisplayHealth()
        {
            Health = Health <= 0 ? 0 : Health;
            if (Health > 0)
            {
                Console.WriteLine($"The Cow currently has {Health} health!");
            }
            else
            {
                Console.WriteLine("Oof. Looks like the Cow died..");
            }
        }

        public void PlaySound()
        {
            Console.WriteLine($"The Cow says: {Sound}!");
        }

        public void IncreaseHealth(int amount)
        {
            Health += amount;
        }
    }
}
