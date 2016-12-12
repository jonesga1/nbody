class Planet
  def initialize(universeMass, x, y, velX, velY, mass, image, windowX, windowY, planetNumbers)
    @universeMass = universeMass
    @x = x
    @y = y
    @velX = velX
    @velY = velY
    @mass = mass
    @image = image
    @windowX = windowX
    @windowY = windowY
    @forceX = 0
    @forceY = 0
    @planetNumbers = planetNumbers
    @gravitationalConstant = 6.67408e-11
  end

  attr_accessor :x, :y, :velX, :velY, :forceX, :forceY, :mass, :image, :planetNumbers

  def forceX(planetX, planetY, mass)
    force = (@gravitationalConstant*@mass*mass)/(((@x - planetX)**2) + ((@y - planetY)**2))
    @forceX -= (force*((@x - planetX)/Math.sqrt(((@x - planetX)**2) + ((@y - planetY)**2))))
  end

  def forceY(planetX, planetY, mass)
    force = (@gravitationalConstant*@mass*mass)/(((@x - planetX)**2) + ((@y - planetY)**2))
    @forceY -= (force*((@y - planetX)/Math.sqrt(((@x - planetX)**2) + ((@y - planetY)**2))))
  end

  def accelX
    acceleration = @forceX/@mass
    @velX += (acceleration*25000)
    @x += @velX * 25000
  end

  def accelY
    acceleration = @forceY/@mass
    @velY += (acceleration*25000)
    @y += @velY * 25000
  end

  def forces0
    @forceX = 0
    @forceY = 0
  end

  def draw
    @image.draw((@x/@universeMass)*(@windowX/2) + (@windowX/2),(@y/@universeMass)*(@windowY/2) + (@windowY/2), 1)
  end
end
