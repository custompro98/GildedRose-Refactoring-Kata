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

    context "sulfuras" do
      let(:name) { "Sulfuras, Hand of Ragnaros" }
      let(:quality) { 80 }

      context "before the sell date" do
        let(:sell_in) { 1 }

        it "does not go up in value and the sell date doesn't change" do
          expect(item.to_s).to eq "#{name}, 1, 80"
        end
      end

      context "after the sell date" do
        let(:sell_in) { 0 }

        it "does not go up in vlaue and the sell date doesn't change" do
          expect(item.to_s).to eq "#{name}, 0, 80"
        end
      end
    end

    context "backstage passes" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      context "at less than max quality" do
        let(:quality) { 47 }

        context "and 11 days before the sell date" do
          let(:sell_in) { 11 }

          it "goes up in value by one" do
            expect(item.to_s).to eq "#{name}, 10, 48"
          end
        end

        context "and 10 days before the sell date" do
          let(:sell_in) { 10 }

          it "goes up in value by two" do
            expect(item.to_s).to eq("#{name}, 9, 49")
          end
        end

        context "and 5 days before the sell date" do
          let(:sell_in) { 5 }

          it "goes up in value by three" do
            expect(item.to_s).to eq("#{name}, 4, 50")
          end
        end

        context "and after the sell date" do
          let(:sell_in) { -1 }

          it "drops to 0 quality" do
            expect(item.to_s).to eq("#{name}, -2, 0")
          end
        end
      end
    end
  end
end
