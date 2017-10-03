module Wizard.Screens.Cards exposing (viewCardsScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a, img, i)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (icon)
import Utils exposing (onClick)


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


callToAction : Products -> Html Msg
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
            text "Let's pick your first gift candidate!"
        else if likesNeeded > 0 then
            text
                ("Can you pick at least "
                    ++ toString likesNeeded
                    ++ " more "
                    ++ optionString
                    ++ "?"
                )
        else
            span []
                [ text "Awesome! Hit "
                , i []
                    [ text "Next" ]
                , text " below whenever you're ready!"
                ]


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
                [ img [ src product.image_url, class "img-fluid" ] []
                , div [ class "product-description" ]
                    [ h2 [ class "name" ]
                        [ text product.name
                        , span [ class "price" ] [ text ("$" ++ toString product.price) ]
                        ]
                    , a [ href product.url, target "_blank", class "btn more" ] [ text "Learn more" ]
                    , p [ class "description" ] [ text product.description ]
                    ]
                , div [ class "text-center buttons" ]
                    [ a
                        [ class "btn btn-primary round"
                        , onClick (Skip product.id)
                        , href "#"
                        ]
                        [ icon "close" ]
                    , a
                        [ class "btn btn-secondary round"
                        , onClick (Like product.id)
                        , href "#"
                        ]
                        [ icon "check" ]
                    ]
                ]

        Nothing ->
            div [ class "product-card" ] [ span [] [ text "No products found." ] ]


viewCardsScreen : Model -> Html Msg
viewCardsScreen model =
    div []
        -- header card with headline and call to action
        [ div [ class "card leader" ]
            [ div [ class "text-center" ]
                [ h1 [] [ text "Anything You'd Like?" ]
                , p [] [ callToAction model.products ]
                ]
            ]

        -- product card
        , div [ id "yes-or-no", class "card product" ]
            [ viewCard (undecidedProducts model.products |> List.head)
            , nextButton <| likedProductsCount model.products
            ]
        ]
