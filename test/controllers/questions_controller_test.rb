require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should get tree" do
    get tree_questions_url
    assert_response :success
  end
end
