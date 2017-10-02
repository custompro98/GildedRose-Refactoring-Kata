require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    let(:item) { Item.new(name, sell_in, quality) }

    before do
      described_class.new(Array(item)).update_quality
    end

    context "aged brie" do
      let(:name) { "Aged Brie" }

      context "at less than max quality" do
        let(:quality) { 49 }

        context "and before the sell date" do
          let(:sell_in) { 1 }

          it "goes up in value" do
            expect(item.to_s).to eq "#{name}, 0, 50"
          end
        end

        context "and after the sell date" do
          let(:sell_in) { 0 }

          it "goes up in value" do
            expect(item.to_s).to eq "#{name}, -1, 50"
          end
        end
      end

      context "at max quality" do
        let(:quality) { 50 }

        context "and before the sell date" do
          let(:sell_in) { 1 }

          it "does not go up in value" do
            expect(item.to_s).to eq "#{name}, 0, 50"
          end
        end

        context "and after the sell date" do
          let(:sell_in) { 0 }

          it "does not go up in value" do
            expect(item.to_s).to eq "#{name}, -1, 50"
          end
        end
      end
    end
  end
end
