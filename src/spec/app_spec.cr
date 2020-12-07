require "./spec_helper"

describe "App" do
    context "when calling root route" do
        it "returns a success response" do
            api_response.status_code.should eq(200)
        end

        it "returns default questions" do
            api_response.body.should eq("{\"q\":\"Are you a robot ?\",\"a\":[\"68934a3e9455fa72420237eb05902327\",\"b326b5062b2f0e69046810717534cb09\"]}"
)
        end
    end

    context "when visiting english route" do
        it "returns a success response" do
            api_response("en").status_code.should eq(200)
        end

        it "returns a question" do
            api_response("?locale=en").body.should eq("{\"q\":\"Are you a robot ?\",\"a\":[\"68934a3e9455fa72420237eb05902327\",\"b326b5062b2f0e69046810717534cb09\"]}")
        end
    end

    context "when visiting french route" do
        it "returns a success response" do
            api_response("locale=fr").status_code.should eq(200)
        end

        it "returns default questions" do
            api_response("fr").body.should eq("{\"q\":\"Êtes-vous une machine ?\",\"a\":[\"14b8f0494c6f1460c3720d0ce692dbca\",\"b2a5abfeef9e36964281a31e17b57c97\"]}")
        end
    end

    context "when visiting a route that is not defined" do
        it "returns a success response" do
            api_response("ys").status_code.should eq(200)
        end

        it "returns default questions" do
            api_response("ys").body.should eq("{\"q\":\"Are you a robot ?\",\"a\":[\"68934a3e9455fa72420237eb05902327\",\"b326b5062b2f0e69046810717534cb09\"]}")
        end
    end
end
