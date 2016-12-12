require "gosu"
require_relative "z_order"
require "./planet.rb"


class NbodySimulation < Gosu::Window

  def initialize
    @simulation = gets.chomp.to_s
    txt = open("simulations/#{@simulation}.txt")
    @windowX = 640
    @windowY = 640
    super(@windowX, @windowY, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    lineCounter = 0
    @planetImage = ""
    @planets = []
    @planetInfo = []
    txt.each_line do |line|
      if lineCounter == 0
        @planetNumbers = line.to_f
      end
      if lineCounter == 1
        @universeSize = line.to_f
      end
      if lineCounter > 1
        if line != "\n" 
          line.split(" ").each do |s|
            @planetInfo.push(s)
          end
          @planetImage = @planetInfo[5].to_s
          planet = Planet.new(@universeSize, @planetInfo[0].to_f, @planetInfo[1].to_f, @planetInfo[2].to_f, @planetInfo[3].to_f, @planetInfo[4].to_f, Gosu::Image.new("images/" + @planetImage), @windowX, @windowY, @planetNumbers)
          @planets.push(planet)
        end
      end
      lineCounter = lineCounter + 1
      @planetInfo = []
    end
    @numberOfPlanets = @planets.length
  end

  def update
    @planets.each do |planet|
      @planets.each do |pl|
        if pl != planet
          planet.forceX(pl.x, pl.y, pl.mass)
          planet.forceY(pl.x, pl.y, pl.mass)
        end
      end
      planet.accelX
      planet.accelY
      planet.forces0
    end

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @planets.each do |planet|
      planet.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

window = NbodySimulation.new
window.show
