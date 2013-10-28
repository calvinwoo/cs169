# Add a declarative step here for populating the DB with movies.
#Movie.new({"title"=>"BEST", "rating"=>"G", "release_date"=>"25-Nov-1992"})



# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert_match(/#{e1}.*#{e2}/m,page.body)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")
  ratings.each do |rating|
    rating = "ratings_"+rating.delete(" ")
    if (uncheck)
        step %{I uncheck "#{rating}"}
    else
        step %{I check "#{rating}"}
    end
  end
    
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  value = Movie.all.length
  (page.all("#movies tr").count-1).should == value
end
