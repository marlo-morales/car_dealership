require "rails_helper"

RSpec.describe "posts", type: :feature do
  let!(:post) { create(:post) }

  it "lists posts" do
    visit root_path

    expect(page).to have_selector(".post--border")
  end

  it "login required to create post" do
    visit new_post_path

    expect(current_path).to eq(login_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("login_required"))
  end

  it "creates new post" do
    login_as(post.author)

    click_link "New Post"
    fill_in "post[title]", with: "RSpec"
    fill_in "post[body]", with: "RSpec"
    click_button "Create Post"

    expect(current_path).to eq(post_path(Post.last))
    expect(Post.last.author).to eq(post.author)
    expect(page).to have_selector(".post__title", text: "RSpec")
    expect(page).to have_selector(".post__body", text: "RSpec")
  end

  it "allows author to update their post" do
    login_as(post.author)

    visit post_path(post)
    click_link "Edit"
    fill_in "post[title]", with: "New Title"
    click_button "Update Post"

    expect(current_path).to eq(post_path(post))
    expect(page).to have_selector(".post__title", text: "New Title")
  end

  it "doesn't allow update to someone else's post" do
    rouge_author = create(:user, username: "rouge")
    login_as(rouge_author)

    visit edit_post_path(post)

    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("unauthorized"))
  end

  it "allows author to remove their post" do
    login_as(post.author)

    visit post_path(post)

    expect { click_link "Delete" }.to change(Post, :count).by(-1)
    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__notice", text: I18n.t("posts.destroy.success"))
  end
end
