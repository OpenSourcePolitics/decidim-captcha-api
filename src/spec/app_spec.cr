require "./spec_helper"

describe "App" do
    context "when calling root route" do
        it "returns a success response" do
            api_response.status_code.should eq(200)
        end

        it "returns default questions" do
            api_response.body.should contain("q")
            api_response.body.should contain("a")
        end
    end

    context "when visiting english route" do
        it "returns a success response" do
            api_response("locale=en").status_code.should eq(200)
        end

        it "returns a question" do
            api_response("locale=en").body.should contain("q")
            api_response("locale=en").body.should contain("a")
        end
    end

    context "when visiting french route" do
        it "returns a success response" do
            api_response("locale=fr").status_code.should eq(200)
        end

        it "returns default questions" do
            api_response("locale=fr").body.should contain("q")
            api_response("locale=fr").body.should contain("a")
        end
    end

    context "when visiting a route that is not defined" do
        it "returns a success response" do
            api_response("locale=ys").status_code.should eq(200)
        end

        it "returns default questions" do
            api_response("locale=ys").body.should contain("q")
            api_response("locale=ys").body.should contain("a")
        end
    end
end
