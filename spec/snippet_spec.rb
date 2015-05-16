require_relative '../lib/snippet'

RSpec.describe 'Snippet' do
  describe 'in Ruby' do
    let(:file_name) { 'test.rb' }

    it 'works' do
      code = <<-CODE
        print "Hello from Ruby!"
      CODE
      snippet = Snippet.new(file_name, code)
      expect(snippet.execute).to eq([true, 'Hello from Ruby!'])
    end
  end
  
  describe 'in C' do
    let(:file_name) { 'test.c' }

    it 'works' do
      code = <<-CODE
      #include<stdio.h>
      main()
      {
          printf("Hello from C!");
      }
      CODE
      snippet = Snippet.new(file_name, code)
      expect(snippet.execute).to eq([true, 'Hello from C!'])
    end
  end
  
  describe 'in Rust' do
    let(:file_name) { 'test.rs' }

    it 'works' do
      code = <<-CODE
      fn main() {
        print!("Hello from Rust!");
      }
      CODE
      snippet = Snippet.new(file_name, code)
      expect(snippet.execute).to eq([true, 'Hello from Rust!'])
    end
  end
end
