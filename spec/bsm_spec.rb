# frozen_string_literal: true

RSpec.describe Bsm do
  it 'has a version number' do
    expect(Bsm::VERSION).not_to be nil
  end

  it 'generates nothing if given nothing' do
    expect(Bsm::Generator.new.generate('')).to eq ''
  end

  it 'generates one char given one char' do
    expect(Bsm::Generator.new.generate('41')).to eq 'A'
  end

  it 'accepts uppercase' do
    expect(Bsm::Generator.new.generate('4A')).to eq 'J'
  end

  it 'accepts lowercase' do
    expect(Bsm::Generator.new.generate('4b')).to eq 'K'
  end

  it 'accepts space delimiter' do
    expect(Bsm::Generator.new.generate('41 42')).to eq 'AB'
  end

  it 'accepts newline delimiter' do
    expect(Bsm::Generator.new.generate("41\n42")).to eq 'AB'
  end

  it 'accepts carriage return delimiter' do
    expect(Bsm::Generator.new.generate("41\r42")).to eq 'AB'
  end

  it 'accepts windows newline delimiter' do
    expect(Bsm::Generator.new.generate("41\r\n42")).to eq 'AB'
  end

  it 'accepts tab delimiter' do
    expect(Bsm::Generator.new.generate("41\t42")).to eq 'AB'
  end

  it 'accepts multiple whitespace delimiters' do
    expect(Bsm::Generator.new.generate("41\t\r\n 42")).to eq 'AB'
  end

  it 'throws error if a byte has only 1 char' do
    expect { Bsm::Generator.new.generate('f') }.to(
      raise_error(Bsm::InvalidInput)
    )
  end

  it 'throws error if a token has 3 chars' do
    expect { Bsm::Generator.new.generate('fff') }.to(
      raise_error(Bsm::InvalidInput)
    )
  end
end
