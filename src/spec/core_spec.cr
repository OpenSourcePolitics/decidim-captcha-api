require "./spec_helper"

describe Core do
  locales_path = "./spec/src/locales"
  subject = Core.new(locales_path)

  describe "#initialize" do
    it "creates the default value" do
      subject.should_not be_nil
      subject.locales_path.should eq("./spec/src/locales")
      subject.locales_loaded?.should be_true
    end
  end

  describe "#load_locales" do
    it "returns proper parsed values" do
      actual = subject.question_and_answers("en")
      actual["a"].should eq([Digest::MD5.hexdigest("no"), Digest::MD5.hexdigest("yes")])
    end
  end

  describe "#question_and_answers" do
    locales_path = "./spec/src/locales"

    context "when fetching a question" do
      it "returns the question with wanted locale" do
        subject.locales_loaded?.should be_true
        actual = subject.question_and_answers("en")
        actual.should be_a Hash(String, Array(String) | String)
        actual.keys.should eq(["q", "a"])

        actual["q"].should eq("Are you a robot ?")
        actual["a"].should_not eq(["no", "yes"])
        actual["a"].should eq(["7fa3b767c460b54a2be4d49030b349c7", "a6105c0a611b41b08f1209506350279e"])
      end

      context "when fetching with 'fr' locale" do
        it "returns the french question" do
          subject.locales_loaded?.should be_true
          actual = subject.question_and_answers("fr")
          actual.should be_a Hash(String, Array(String) | String)
          actual.keys.should eq(["q", "a"])

          actual["q"].should eq("Êtes-vous une machine ?")
          actual["a"].should_not eq(["non", "oui"])
          actual["a"].should eq(["14b8f0494c6f1460c3720d0ce692dbca", "b2a5abfeef9e36964281a31e17b57c97"])
        end
      end

      context "when fetching with unknown locale" do
        it "returns the english question" do
          locale = "it"

          actual = subject.question_and_answers(locale)

          actual.should be_a Hash(String, Array(String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["7fa3b767c460b54a2be4d49030b349c7", "a6105c0a611b41b08f1209506350279e"])
        end
      end

      context "when locale is empty" do
        it "returns the english question" do
          locale = ""

          actual = subject.question_and_answers(locale)

          actual.should be_a Hash(String, Array(String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["7fa3b767c460b54a2be4d49030b349c7", "a6105c0a611b41b08f1209506350279e"])
        end
      end

      context "when locale is not an existing locale" do
        it "returns the english question" do
          locale = "this is a fake locale"

          actual = subject.question_and_answers(locale)

          actual.should be_a Hash(String, Array(String) | String)
          actual["q"].should eq("Are you a robot ?")
          actual["a"].should_not eq(["no", "yes"])
          actual["a"].should eq(["7fa3b767c460b54a2be4d49030b349c7", "a6105c0a611b41b08f1209506350279e"])
        end
      end
    end
  end
end
