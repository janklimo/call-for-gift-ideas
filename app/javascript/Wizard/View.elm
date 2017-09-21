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


undecidedProducts : List ( Product, Extensions ) -> List ( Product, Extensions )
undecidedProducts products =
    List.filter (\( p, e ) -> e.liked == Nothing) products


likedProducts : List ( Product, Extensions ) -> List ( Product, Extensions )
likedProducts products =
    List.filter (\( p, e ) -> e.liked == Just True) products


likedProductsCount : List ( Product, Extensions ) -> Int
likedProductsCount products =
    products
        |> likedProducts
        |> List.length


callToAction : List ( Product, Extensions ) -> String
callToAction products =
    let
        minimum =
            2

        likedCount =
            likedProductsCount products

        likesNeeded =
            minimum - likedCount

        optionString =
            if likesNeeded > 1 then
                "options"
            else
                "option"
    in
        if likedCount == 0 then
            "Let's pick your first gift candidate!"
        else if likedCount < minimum then
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
        , a
            [ class "btn btn-primary"
            , onClick (Navigate Sort)
            , href "#"
            ]
            [ text "Next" ]
        ]


viewCard : Maybe ( Product, Extensions ) -> Html Msg
viewCard product =
    case product of
        Just ( product, extensions ) ->
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


viewSortScreen : Model -> Html Msg
viewSortScreen model =
    div [ class "sort-page" ]
        [ div [ class "text-center" ]
            [ h1 [] [ text "Any Preferences?" ]
            , p [] [ text "Let's order your wishlist before we're done!" ]
            ]
        ]


view : Model -> Html Msg
view model =
    case model.currentPage of
        Welcome ->
            viewWelcomeScreen model.recipientName

        Cards ->
            viewCardsScreen model

        Sort ->
            viewSortScreen model
