; Create templates
(deftemplate Recipe
   (slot name)
   (slot cuisine)
   (slot difficulty)
   (slot ingredients)
   (slot instructions)
)

(deftemplate User
   (slot name)
   (slot cuisine-preference)
   (slot difficulty-preference)
   (slot ingredient-preference)
)

; Create Rules

(defrule GetUserPreferences
    (not (User (name ?name)))
    =>
    ; inputs for user
    (printout t "insert your name !")
    (bind ?name (read))
    (printout t "Welcome, " ?name ". Let's find you a recipe!" crlf)
    (printout t "What cuisine do you prefer? ")
    (bind ?cuisine-pref (read))
    (printout t "How difficult should the recipe be? (Easy, Intermediate, Difficult) ")
    (bind ?difficulty-pref (read))
    (printout t "Do you have any specific ingredient preferences? ")
    (bind ?ingredient-pref (read))
    ; create new user fact
    (assert (User 
        (name ?name)
        (difficulty-preference ?difficulty-pref)
        (cuisine-preference ?cuisine-pref)
        (ingredient-preference ?ingredient-pref)
    ))
)


(defrule RecommendRecipe
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
        (difficulty-preference ?difficulty-pref)
        (ingredient-preference ?ingredient-pref)
    )
    (Recipe 
        (name ?recipe)
        (cuisine ?cuisine)
        (difficulty ?difficulty)
        (ingredients ?ingredients)
    )
    (test (eq ?cuisine ?cuisine-pref))
    (test (eq ?difficulty ?difficulty-pref))
    (test (str-compare ?ingredients ?ingredient-pref))
    =>
    (printout t "---" crlf)
    (printout t "Based on your preferences, we recommend: " ?recipe crlf)
    (printout t "Ingredients: " ?ingredients crlf)
    (printout t "Enjoy your meal!" crlf)
    ;(retract (User (name ?name)))
    ;(retract (Recipe (name ?recipe)))
)

(defrule PrintRecipesByCuisine
    ?user <- (User (name ?username) (cuisine-preference ?cuisine-dish))
    =>
    (printout t "---" crlf)
    (printout t "<< Recipes for " ?cuisine-dish " Cuisine >>" crlf)
    (bind ?count 0)
    (do-for-all-facts ((?recipe Recipe)) (eq ?recipe:cuisine ?cuisine-dish)
        (bind ?count (+ ?count 1))
        (printout t "Recipe #" ?count ":" crlf)
        (printout t "Name: " ?recipe:name crlf)
    )
)

(defrule PrintRecipesByDifficulty
    ?user <- (User (name ?username) (difficulty-preference ?difficulty-dish))
    =>
    (printout t "---" crlf)
    (printout t "<< Recipes for " ?difficulty-dish " Difficulty >>" crlf)
    (bind ?count 0)
    (do-for-all-facts ((?recipe Recipe)) (eq ?recipe:difficulty ?difficulty-dish)
        (bind ?count (+ ?count 1))
        (printout t "Recipe #" ?count ":" crlf)
        (printout t "Name: " ?recipe:name crlf)
    )
)

(defrule PrintRecipesByingredient
    ?user <- (User (name ?username) (ingredient-preference ?ingredient-dish))
    =>
    (printout t "---" crlf)
    (printout t "<< Recipes for " ?ingredient-dish " Ingredient >>" crlf)
    (bind ?count 0)
    (do-for-all-facts ((?recipe Recipe)) (neq (str-index ?ingredient-dish ?recipe:ingredients ) FALSE)
        (bind ?count (+ ?count 1))
        (printout t "Recipe #" ?count ":" crlf)
        (printout t "Name: " ?recipe:name crlf)
    )
)

(defrule ExitRecommendation
   (User (name ?name))
   =>
   (printout t "---" crlf)
   (printout t "Thank you for using the personalized recipe recommender, " ?name "!" crlf)
   ;(retract (User (name ?name)))
   ;(exit)
)


; (deffacts SampleUsers
;     (User 
;         (name "John Doe")
;         (difficulty-preference Easy)
;         (cuisine-preference Italian)
;         (ingredient-preference "cheese")
;     )

;     (User 
;         (name "Jane Doe")
;         (difficulty-preference Intermediate)
;         (cuisine-preference Indian)
;         (ingredient-preference "rice")
;     )
; )

; set initial facts

(deffacts SampleRecipes
    (Recipe 
        (name "Spaghetti Carbonara") 
        (cuisine Italian) 
        (difficulty Easy)
        (ingredients "spaghetti, eggs, bacon, Parmesan cheese") 
        (instructions "1. Cook spaghetti. 2. Fry bacon. 3. Mix eggs and cheese. 4. Toss with pasta.")
    )

    (Recipe 
        (name "Chicken Tikka Masala") 
        (cuisine Indian) 
        (difficulty Intermediate)
        (ingredients "chicken, yogurt, tomato sauce, spices") 
        (instructions "1. Marinate chicken. 2. Cook chicken. 3. Simmer in sauce.")
    )

    (Recipe 
    (name "Grilled Cheese Sandwich") 
    (cuisine American) 
    (difficulty Easy)
    (ingredients "bread, butter, cheese") 
    (instructions "1. Butter bread slices. 2. Add cheese between slices. 3. Grill until golden brown.")
)

(Recipe 
    (name "Caesar Salad") 
    (cuisine Italian) 
    (difficulty Easy)
    (ingredients "romaine lettuce, croutons, Parmesan cheese, Caesar dressing") 
    (instructions "1. Toss lettuce with dressing. 2. Add croutons and cheese.")
)

(Recipe 
    (name "Beef Stir-Fry") 
    (cuisine Chinese) 
    (difficulty Intermediate)
    (ingredients "beef, bell peppers, broccoli, soy sauce, garlic") 
    (instructions "1. Stir-fry beef and garlic. 2. Add vegetables and soy sauce.")
)

(Recipe 
    (name "Mushroom Risotto") 
    (cuisine Italian) 
    (difficulty Intermediate)
    (ingredients "rice, mushrooms, onion, white wine, chicken broth") 
    (instructions "1. Sauté onions and mushrooms. 2. Add rice and wine. 3. Gradually add broth.")
)

(Recipe 
    (name "Spicy Tofu Curry") 
    (cuisine Indian) 
    (difficulty Intermediate)
    (ingredients "tofu, coconut milk, curry paste, vegetables") 
    (instructions "1. Sauté tofu and vegetables. 2. Simmer in coconut milk and curry paste.")
)

(Recipe 
    (name "Fish Tacos") 
    (cuisine Mexican) 
    (difficulty Easy)
    (ingredients "fish fillets, tortillas, cabbage, salsa") 
    (instructions "1. Fry fish. 2. Assemble tacos with cabbage and salsa.")
)

(Recipe 
    (name "Pasta Primavera") 
    (cuisine Italian) 
    (difficulty Easy)
    (ingredients "pasta, mixed vegetables, olive oil, Parmesan cheese") 
    (instructions "1. Sauté vegetables. 2. Toss with cooked pasta and cheese.")
)

(Recipe 
    (name "Chicken Noodle Soup") 
    (cuisine American) 
    (difficulty Easy)
    (ingredients "chicken, noodles, carrots, celery, chicken broth") 
    (instructions "1. Cook chicken and vegetables in broth. 2. Add noodles.")
)

(Recipe 
    (name "Greek Salad") 
    (cuisine Greek) 
    (difficulty Easy)
    (ingredients "cucumbers, tomatoes, feta cheese, olives, olive oil") 
    (instructions "1. Combine vegetables, cheese, and olives. 2. Drizzle with olive oil.")
)

(Recipe 
    (name "Beef Tacos") 
    (cuisine Mexican) 
    (difficulty Easy)
    (ingredients "ground beef, taco seasoning, tortillas, lettuce, cheese") 
    (instructions "1. Brown beef with seasoning. 2. Assemble tacos with lettuce and cheese.")
)

(Recipe 
    (name "Shrimp Scampi") 
    (cuisine Italian) 
    (difficulty Intermediate)
    (ingredients "shrimp, garlic, white wine, butter, pasta") 
    (instructions "1. Sauté shrimp and garlic in butter. 2. Add white wine and serve over pasta.")
)

(Recipe 
    (name "Vegetable Curry") 
    (cuisine Indian) 
    (difficulty Easy)
    (ingredients "assorted vegetables, curry sauce, rice") 
    (instructions "1. Cook vegetables in curry sauce. 2. Serve over rice.")
)

(Recipe 
    (name "Caprese Salad") 
    (cuisine Italian) 
    (difficulty Easy)
    (ingredients "tomatoes, fresh mozzarella, basil, balsamic glaze") 
    (instructions "1. Arrange tomato and mozzarella slices. 2. Top with basil and drizzle with balsamic glaze.")
)

(Recipe 
    (name "Teriyaki Chicken") 
    (cuisine Japanese) 
    (difficulty Intermediate)
    (ingredients "chicken thighs, teriyaki sauce, broccoli, rice") 
    (instructions "1. Marinate chicken in teriyaki sauce. 2. Grill and serve with steamed broccoli and rice.")
)

(Recipe 
    (name "Pesto Pasta") 
    (cuisine Italian) 
    (difficulty Easy)
    (ingredients "pasta, basil pesto, cherry tomatoes, pine nuts") 
    (instructions "1. Toss cooked pasta with pesto. 2. Garnish with cherry tomatoes and pine nuts.")
)

(Recipe 
    (name "Beef and Broccoli Stir-Fry") 
    (cuisine Chinese) 
    (difficulty Intermediate)
    (ingredients "beef, broccoli, soy sauce, ginger, garlic") 
    (instructions "1. Stir-fry beef with ginger and garlic. 2. Add broccoli and soy sauce.")
)

(Recipe 
    (name "Chicken Fajitas") 
    (cuisine Mexican) 
    (difficulty Easy)
    (ingredients "chicken breasts, bell peppers, onions, fajita seasoning, tortillas") 
    (instructions "1. Sauté chicken, peppers, and onions with fajita seasoning. 2. Serve in tortillas.")
)

(Recipe 
    (name "Egg Fried Rice") 
    (cuisine Chinese) 
    (difficulty Easy)
    (ingredients "rice, eggs, peas, carrots, soy sauce") 
    (instructions "1. Scramble eggs and add to cooked rice with peas, carrots, and soy sauce.")
)

(Recipe 
    (name "Mango Salsa") 
    (cuisine Mexican) 
    (difficulty Easy)
    (ingredients "mangoes, red onion, cilantro, lime juice, jalapeño") 
    (instructions "1. Dice mangoes and mix with chopped onion, cilantro, lime juice, and jalapeño.")
)

)