require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user.save
    @post = Post.new(title: "Example post title", body: "Example post body", user: @user)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = "     "
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = "     "
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 65
    assert_not @post.valid?
  end

  test "body should not be too long" do
    @post.body = "a" * 1025
    assert_not @post.valid?
  end
end
