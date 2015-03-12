class Robot

  attr_accessor :position, :items, :capacity, :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @capacity = 250
    @health = 100
    @equipped_weapon = nil
  end

  def attack(enemy)
    @equipped_weapon ? @equipped_weapon.hit(enemy) : enemy.wound(5)
  end

  def wound(hit_points)
    @health -= hit_points
    @health = 0 if @health < 0
  end

  def heal!
    if @health <= 0
      raise Exception
        puts "Error this robot is dead and cannot be revived"
    else
      @health += health_kit
      @health = 100 if @health > 100
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

  def pick_up(item)
    if(items_weight + item.weight) <= @capacity
      @equipped_weapon  = item if item.is_a? Weapon
      @items << item 
    end 
  end



end
