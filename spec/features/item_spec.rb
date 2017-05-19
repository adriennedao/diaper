RSpec.feature "Item management", type: :feature do
    
  scenario "User creates a new item" do
    visit '/items/new'
    item_traits = attributes_for(:item)
    fill_in "Name", with: item_traits[:name]
    fill_in "Category", with: item_traits[:category]
    click_button "Create Item"

    expect(page.find('.flash.success')).to have_content "added"
  end

  scenario "User updates an existing item" do
    item = create(:item)
    visit "/items/#{item.id}/edit"
    fill_in "Category", with: item.category + " new"
    click_button "Update Item"

    expect(page.find('.flash.success')).to have_content "updated"
  end

   scenario "User can filter the #index by category type" do
    item = create(:item, category: "same")
    item2 = create(:item, category: "different")
    visit "/items"
    select Item.first.category, from: "filters_in_category"
    click_button "Filter"

    expect(page).to have_css("table tbody tr", count: 1)
  end


end