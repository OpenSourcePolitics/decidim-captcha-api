require "./spec_helper"

describe Core do
  locales_path = "./spec/src/locales"
  subject = Core.new(locales_path)

  describe "#initialize" do
    it "creates the default value" do
      actual = subject

      actual.should_not be_nil
      actual.locales_path.should eq("./spec/src/locales")
      actual.locales_loaded?.should be_true
    end
  end

  describe "#question_and_answers" do
    locales_path = "./spec/src/locales"

    context "when fetching a question" do
      it "returns the question with wanted locale" do
        core = subject

        core.locales_loaded?.should be_true
        actual = core.question_and_answers("en")
        actual.should be_a Hash(String, Array(Int32 | String) | String)
        actual.keys.should eq(["q", "a"])

        actual["q"].should eq("Are you a robot ?")
        actual["a"].should_not eq(["no", "yes"])
        actual["a"].should eq(["68934a3e9455fa72420237eb05902327", "b326b5062b2f0e69046810717534cb09"])
      end

      context "when fetching with 'fr' locale" do
        it "returns the french question" do
          core = subject

          core.locales_loaded?.should be_true
          actual = core.question_and_answers("fr")
          actual.should be_a Hash(String, Array(Int32 | String) | String)
          actual.keys.should eq(["q", "a"])

          actual["q"].should eq("Êtes-vous une machine ?")
          actual["a"].should_not eq(["non", "oui"])
          actual["a"].should eq(["14b8f0494c6f1460c3720d0ce692dbca", "b2a5abfeef9e36964281a31e17b57c97"])
        end
      end

      context "when fetching with unknown locale" do
        it "returns the english question" do
          core = subject
          locale = "it"

          actual = core.question_and_answers(locale)

          actual.should be_a Hash(String, Array(Int32 | String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["68934a3e9455fa72420237eb05902327", "b326b5062b2f0e69046810717534cb09"])
        end
      end

      context "when locale is empty" do
        it "returns the english question" do
          core = subject
          locale = ""

          actual = core.question_and_answers(locale)

          actual.should be_a Hash(String, Array(Int32 | String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["68934a3e9455fa72420237eb05902327", "b326b5062b2f0e69046810717534cb09"])
        end
      end

      context "when locale is not an existing locale" do
        it "returns the english question" do
          core = subject
          locale = "this is a fake locale"

          actual = core.question_and_answers(locale)

          actual.should be_a Hash(String, Array(Int32 | String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["68934a3e9455fa72420237eb05902327", "b326b5062b2f0e69046810717534cb09"])
        end
      end
    end
  end
end
