require "spec_helper"
require "post"

describe Post do
  describe "#today" do
    it "returns posts created today" do
      todays_posts = double("todays_posts")
      allow(Post).to receive(:today).and_return(todays_posts)
      result = Post.today

      expect(result).to eq(todays_posts)
    end
  end

  describe "#visible_to" do
    it "returns published posts" do
      author = double(:user)
      published_posts = double("published_posts")

      allow(Post).to receive(:visible_to).with(author)
      .and_return(published_posts)

      result = Post.visible_to(author)

      expect(result).to eq(published_posts)
    end

    it "returns unpublished posts authored by the given user" do
      unpublished_posts = double("unpublished_posts")
      viewer = double("User")

      allow(Post).to receive(:visible_to).with(viewer)
      .and_return(unpublished_posts)

      result = Post.visible_to(viewer)

      expect(result).to eq(unpublished_posts)
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end
