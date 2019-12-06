require 'bitmap_editor.rb'

describe BitmapEditor do
  let(:input_line) { 'I 5 6' }
  let(:colour_line) { 'L 1 3 A' }
  let(:vdraw_line) { 'V 2 3 6 W' }
  let(:hdraw_line) { 'H 3 5 2 Z' }
  let(:bitmap) { subject.input(input_line) }
  let(:result) {
                 [['O', 'O', 'O', 'O', 'O'], \
                  ['O', 'O', 'Z', 'Z', 'Z'], \
                  ['A', 'W', 'O', 'O', 'O'], \
                  ['O', 'W', 'O', 'O', 'O'], \
                  ['O', 'W', 'O', 'O', 'O'], \
                  ['O', 'W', 'O', 'O', 'O']]
               }

  it 'creates a matrix with given params' do
    expect(bitmap.count).to eq(6)
    expect(bitmap.first.count).to eq(5)
    expect(subject.read(bitmap)).to eq(Array.new(30, 'O'))
  end

  it 'Clears the table, setting all pixels to white (O)' do
    cleared = subject.clear(bitmap)
    expected_values = subject.read(cleared)

    expected_values.each do |val|
      expect(val).to eq('O')
    end
    expect(cleared.count).to eq(6)
    expect(cleared.first.count).to eq(5)
  end

  it 'Colours the pixel' do
    bmp = subject.colours(bitmap, colour_line)

    expect(bmp[2][0]).to eq('A')
  end

  it 'Draw a vertical segment' do
    bmp = subject.vdraw(bitmap, vdraw_line)

    (3..6).each do |e|
      expect(bmp[e - 1][1]).to eq('W')
    end
  end

  it 'Draw a horizontal segment' do
    bmp = subject.hdraw(bitmap, hdraw_line)

    (3..5).each do |e|
      expect(bmp[1][e - 1]).to eq('Z')
    end
  end

  it 'Show the contents of current image' do
    a = subject.colours(bitmap, colour_line)
    b = subject.vdraw(a, vdraw_line)
    c = subject.hdraw(b, hdraw_line)
    expect(c).to eq(result)
  end
end
