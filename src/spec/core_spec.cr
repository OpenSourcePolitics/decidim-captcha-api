require "./spec_helper"

describe Core do
  locales_path = "./spec/src/locales"

  describe "#initialize" do
    it "creates the default value" do
      actual = Core.new(locales_path)

      actual.should_not be_nil
      actual.locales_path.should eq("./spec/src/locales")
      actual.locales_loaded?.should be_true
    end
  end

  describe "#question_and_answers" do
    locales_path = "./spec/src/locales"

    context "when fetching a question" do
      it "returns the question with wanted locale" do
        core = Core.new(locales_path)

        core.locales_loaded?.should be_true
        actual = core.question_and_answers("en")
        actual.should be_a Hash(String, Array(Int32 | String) | String)
        actual.keys.size.should eq(2)
        actual.keys[0].should eq("q")
        actual.keys[1].should eq("a")

        actual["q"].should eq("Are you a robot ?")
        actual["a"].should_not eq(["no", "yes"])
        actual["a"].should eq(["68934a3e9455fa72420237eb05902327", "b326b5062b2f0e69046810717534cb09"])
      end
    end
  end
end
