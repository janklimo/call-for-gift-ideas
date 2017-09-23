module Wizard.Screens.Cards exposing (viewCardsScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (icon)


undecidedProducts : Products -> List ( Product, Extensions )
undecidedProducts products =
    List.filter (\( p, e ) -> e.liked == Nothing) products


likedProducts : Products -> List ( Product, Extensions )
likedProducts products =
    List.filter (\( p, e ) -> e.liked == Just True) products


likedProductsCount : Products -> Int
likedProductsCount products =
    products
        |> likedProducts
        |> List.length


minimumLikedCount : Int
minimumLikedCount =
    2


callToAction : Products -> String
callToAction products =
    let
        likedCount =
            likedProductsCount products

        likesNeeded =
            minimumLikedCount - likedCount

        optionString =
            if likesNeeded > 1 then
                "options"
            else
                "option"
    in
        if likedCount == 0 then
            "Let's pick your first gift candidate!"
        else if likesNeeded > 0 then
            "Can you pick at least "
                ++ toString likesNeeded
                ++ " more "
                ++ optionString
                ++ "?"
        else
            "Awesome! Hit Next below whenever you're ready!"


nextButton : Int -> Html Msg
nextButton count =
    if count >= minimumLikedCount then
        div [ class "text-center" ]
            [ a
                [ class "btn btn-primary"
                , onClick (Navigate Sort)
                , href "#"
                ]
                [ text "Next" ]
            ]
    else
        div [] []


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


viewCardsScreen : Model -> Html Msg
viewCardsScreen model =
    div [ class "cards-page" ]
        [ div [ class "text-center" ]
            [ h1 [] [ text "Anything You'd Like?" ]
            , p [] [ text (callToAction model.products) ]
            ]
        , viewCard (undecidedProducts model.products |> List.head)
        , nextButton <| likedProductsCount model.products
        ]
