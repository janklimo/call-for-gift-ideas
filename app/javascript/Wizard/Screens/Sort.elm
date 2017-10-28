module Wizard.Screens.Sort exposing (viewSortScreen)

import Html exposing (Html, text, div, h1, h2, span, p, a, img)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (..)
import Utils exposing (onClick)
import Animation
import Animation.Messenger


-- import Set exposing (Set)


viewSortScreen : Model -> Html Msg
viewSortScreen model =
    div [ class "card", id "sort-screen" ]
        [ div [ class "text-center" ]
            [ h1 [] [ text "Any Preferences?" ]
            , p [] [ text "Let's order your wishlist before we're done!" ]
            ]
        , div [ class "wishlist-items-container" ]
            [ h2 [ class "text-center" ] [ text "OMG I need this in my life  😻" ]
            , model.products
                |> likedProducts
                |> sortedByRank
                |> viewWishlist model.cardStyle
            , h2 [ class "text-center" ] [ text "Nice to have" ]
            ]
        ]


viewWishlist : Animation.Messenger.State msgA -> List ( Product, Extensions ) -> Html Msg
viewWishlist cardStyle products =
    let
        productRow ( product, extensions ) =
            let
                animationStyle =
                    -- this is nonsense, need to pass the whole model because I need the set cardRanksToSwap
                    Animation.render cardStyle
            in
                div (animationStyle ++ [ class "row wishlist-item" ])
                    [ div [ class "wishlist-item__image-container col-sm-3" ]
                        [ img [ class "wishlist-item__image img-fluid", src product.image_url ] []
                        , span [ class "wishlist-item__rank" ] [ text (toString extensions.rank) ]
                        ]
                    , div [ class "col-sm-6" ]
                        [ p [ class "wishlist-item__name" ] [ text product.name ]
                        , p [ class "wishlist-item__price" ] [ text <| "$" ++ toString product.price ]
                        ]
                    , div [ class "wishlist-item__buttons col-sm-3" ]
                        [ upvoteButton extensions.rank
                        , downvoteButton extensions.rank products
                        ]
                    ]
    in
        div [ class "wishlist-container" ] (List.map productRow products)


upvoteButton : Int -> Html Msg
upvoteButton rank =
    -- can't move #1 product up
    if rank > 1 then
        a
            [ class "btn btn-secondary round"
            , onClick <| SwapCards (Up rank)
            , href "#"
            ]
            [ icon "arrow-up" ]
    else
        text ""


downvoteButton : Int -> Products -> Html Msg
downvoteButton rank products =
    -- can't move the last product down
    if rank < List.length products then
        a
            [ class "btn btn-primary round"
            , onClick <| SwapCards (Down rank)
            , href "#"
            ]
            [ icon "arrow-down" ]
    else
        text ""
