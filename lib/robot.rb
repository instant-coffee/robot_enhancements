class Robot

  attr_accessor :position, :items, :capacity, :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @capacity = 250
    @health = 100
    @equipped_weapon = nil
  end

  def in_range?(enemy)
    if ( (enemy.position[1] - @position[1]).abs <= 1) && ((enemy.position[0] - @position[0]).abs <= 1)
      true
    else
      false
    end
  end

  def in_grenade_range?(enemy)
    if ( (enemy.position[1] - @position[1]).abs <= 2) && ((enemy.position[0] - @position[0]).abs <= 2)
      true
    else
      false
    end
  end

  def grenade_attack(enemy)
    if in_grenade_range?(enemy)
      @equipped_weapon.hit(enemy)
    end
    @equipped_weapon = nil
  end

  def attack(enemy)
    grenade_attack(enemy) if @equipped_weapon.is_a?( Grenade )
    if in_range?(enemy)
      @equipped_weapon ? @equipped_weapon.hit(enemy) : enemy.wound(5)
    end
  end

  def wound(hit_points)
    @health -= hit_points
    @health = 0 if @health < 0
  end

  def heal!
    if @health <= 0
      raise RobotAlreadyDeadError
        puts "Error this robot is dead and cannot be revived"
    else
      @health += health_kit
      @health = 100 if @health > 100
    end
  end

  def heal(health_kit)
    @health += health_kit
    @health = 100 if @health > 100
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def items_weight
    @items.inject(0) {|sum, i| sum += i.weight }
  end

  def auto_heal(item)
    if ( @health <= 80 ) && ( item.is_a? BoxOfBolts )
      item.feed(self) 
    end
  end

  def pick_up(item)
    if(items_weight + item.weight) <= @capacity
      auto_heal(item)
      @equipped_weapon  = item if item.is_a? Weapon
      @items << item 
    end 
  end



end
