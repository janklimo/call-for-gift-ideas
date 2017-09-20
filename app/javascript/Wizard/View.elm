module Wizard.View exposing (..)

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (icon)


viewWelcomeScreen : String -> Html Msg
viewWelcomeScreen name =
    div [ class "welcome-page" ]
        [ h1 [ class "text-center" ] [ text ("Hey, " ++ name ++ "!") ]
        , div [ class "text-center" ]
            [ p [] [ text "Somebody wants to get you a present you'll actually love 😻" ]
            , p [] [ text "Help them by selecting a handful of options you'd like to find under the 🎄" ]
            , p [] [ text "This won't take more than 3 minutes 🚀" ]
            , p [] [ text "Ready?" ]
            , a
                [ class "btn btn-primary"
                , onClick (Navigate Cards)
                , href "#"
                ]
                [ text "Let's Go!" ]
            ]
        ]


undecidedProducts : List Product -> List Product
undecidedProducts products =
    List.filter (\p -> p.liked == Nothing) products


likedProducts : List Product -> List Product
likedProducts products =
    List.filter (\p -> p.liked == Just True) products


callToAction : List Product -> String
callToAction products =
    let
        minimum =
            2

        likedProductsCount =
            likedProducts products |> List.length

        likesNeeded =
            minimum - likedProductsCount

        optionString =
            if likesNeeded > 1 then
                "options"
            else
                "option"
    in
        if likedProductsCount == 0 then
            "Let's pick your first gift candidate!"
        else if likedProductsCount < minimum then
            "Can you pick at least "
                ++ toString likesNeeded
                ++ " more "
                ++ optionString
                ++ "?"
        else
            "Awesome! Hit Next below whenever you're ready!"


viewCardsScreen : Model -> Html Msg
viewCardsScreen model =
    div [ class "cards-page" ]
        [ h1 [] [ text "Anything You'd Like?" ]
        , p []
            [ text (callToAction model.products) ]
        , viewCard (undecidedProducts model.products |> List.head)
        ]


viewCard : Maybe Product -> Html Msg
viewCard product =
    case product of
        Just product ->
            div [ class "product-card" ]
                [ h2 [] [ text product.name ]
                , p [] [ text ("$" ++ toString product.price) ]
                , a
                    [ class "btn btn-primary"
                    , onClick (Skip product.id)
                    , href "#"
                    ]
                    [ icon "close" ]
                , a
                    [ class "btn btn-secondary"
                    , onClick (Like product.id)
                    , href "#"
                    ]
                    [ icon "check" ]
                ]

        Nothing ->
            div [ class "product-card" ] [ span [] [ text "No products found." ] ]


viewScreen : Model -> Html Msg
viewScreen model =
    case model.currentPage of
        Welcome ->
            viewWelcomeScreen model.recipientName

        Cards ->
            viewCardsScreen model


view : Model -> Html Msg
view model =
    viewScreen model
