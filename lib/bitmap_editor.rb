class String
  def element(position)
    element = chomp.split(' ')[position]
    return element.to_i if element =~ /[[:digit:]]/

    element
  end
end

class BitmapEditor
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)
    bitmap = []
    File.open(file).each do |line|
      cmd = line.element(0)
      case cmd
      when 'I'
        bitmap = input(line)
      when 'C'
        bitmap = clear(bitmap)
      when 'L'
        bmp = colours(bitmap, line)
        bitmap = bmp
      when 'V'
        bmp = vdraw(bitmap, line)
        bitmap = bmp
      when 'H'
        bmp = hdraw(bitmap, line)
        bitmap = bmp
      when 'S'
        pp bitmap
      else
        puts 'unrecognised command :('
      end
    end
  end

  def input(line)
    bitmap = []
    n = line.element(1)
    m = line.element(2)
    return puts 'Pixel coordinates number should be between 1 and 250' \
      if n > 250 || m > 250

    Array.new(m) { Array.new(n, 'O') }
  end

  def clear(bmp)
    input("I #{bmp.first.count} #{bmp.count}")
  end

  def read(bmp)
    bitmap = []
    bmp.each { |x| x.each { |y| bitmap << y } }

    bitmap
  end

  def colours(bmp, line)
    x = line.element(1)
    y = line.element(2)
    c = line.element(3)
    bmp[y - 1][x - 1] = c

    bmp
  end

  def vdraw(bmp, line)
    x = line.element(1)
    y1 = line.element(2)
    y2 = line.element(3)
    c = line.element(4)
    (y1..y2).each do |y|
      bmp[y - 1][x - 1] = c
    end

    bmp
  end

  def hdraw(bmp, line)
    y = line.element(3)
    x1 = line.element(1)
    x2 = line.element(2)
    c = line.element(4)
    (x1..x2).each do |x|
      bmp[y - 1][x - 1] = c
    end

    bmp
  end
end
