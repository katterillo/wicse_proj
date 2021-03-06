class Spoonacular

    CUISINES = %w[African
        American
        British
        Cajun
        Caribbean
        Chinese
        Eastern European
        European
        French
        German
        Greek
        Indian
        Irish
        Italian
        Japanese
        Jewish
        Korean
        Latin American
        Mediterranean
        Mexican
        Middle Eastern
        Nordic
        Southern
        Spanish
        Thai
        Vietnamese]
        INTOLERANCES = %w[Dairy
            Egg
            Gluten
            Grain
            Peanut
            Seafood
            Sesame
            Shellfish
            Soy
            Sulfite
            Tree Nut
            Wheat]
    def self.search_recipes(query, cuisine = nil, intolerances = nil)
        resp = Faraday.get('https://api.spoonacular.com/recipes/complexSearch') do |req|
            req.params['apiKey'] = ENV["SPOONACULAR_API_KEY"]
            req.params['includeIngredients'] = query
            req.params['fillIngredients'] = true
            req.params['cuisine'] = cuisine if cuisine.present?
            req.params['intolerances'] = intolerances if intolerances.present?
          end
          return JSON.parse(resp.body)["results"]
    end

    def self.find_recipe(id)
        resp = Faraday.get("https://api.spoonacular.com/recipes/#{id}/information") do |req|
            req.params['apiKey'] = ENV["SPOONACULAR_API_KEY"]
            end
          return JSON.parse(resp.body)
    end
end