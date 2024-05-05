require "test_helper"

class TurboClone::StreamsHelperTest < ActionDispatch::IntegrationTest
  test "create with respond to html" do
    post articles_path, params: { article: { content: "something" } }
    assert_redirected_to articles_path

    post articles_path, params: { article: { content: "something" } }, as: :turbo_stream
    assert_turbo_stream action: "prepend", target: "articles"
  end

  test "udpate with respond to" do
    article = Article.create! content: "Hello"
    patch article_path(article), params: { article: { content: "something" } }
    assert_redirected_to articles_path

    patch article_path(article), params: { article: { content: "something S" } }, as: :turbo_stream
    assert_turbo_stream action: "replace", target: article
  end

  test "destroy with respond to" do
    article = Article.create! content: "Hello"
    delete article_path(article)
    assert_redirected_to articles_path

    article = Article.create! content: "Hello"
    delete article_path(article), as: :turbo_stream
    assert_turbo_stream action: "remove", target: article
  end
end
