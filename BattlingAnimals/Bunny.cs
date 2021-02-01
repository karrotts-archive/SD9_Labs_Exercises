using System;
using System.Collections.Generic;
using System.Text;

namespace BattlingAnimals
{
    class Bunny
    {
        public int Health { get; set; }
        public int Defense { get; set; }
        public int Attack { get; set; }
        public string Sound { get; set; }

        public Bunny(int health, int defense, int attack, string sound)
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
                double totalDefense = (double)Defense / 100;
                int totalDamage = (int)(totalDefense * damage);

                Console.WriteLine($"The bunny has taken {totalDamage} damage!");
                Health -= totalDamage;
            }
        }

        public void DisplayHealth()
        {
            Health = Health <= 0 ? 0 : Health;
            if(Health > 0)
            {
                Console.WriteLine($"The Bunny currently has {Health} health!");
            }
            else
            {
                Console.WriteLine("Oof. Looks like the bunny died..");
            }
        }

        public void PlaySound()
        {
            Console.WriteLine($"The Bunny says: {Sound}!");
        }

        public void IncreaseHealth(int amount)
        {
            Health += amount;
        }
    }
}
