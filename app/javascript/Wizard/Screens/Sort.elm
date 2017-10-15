module Wizard.Screens.Sort exposing (viewSortScreen)

import Html exposing (Html, text, div, h1, h2, span, p, a, img)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (..)
import Utils exposing (onClick)


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
                |> viewWishlist
            , h2 [ class "text-center" ] [ text "Nice to have" ]
            ]
        ]


viewWishlist : Products -> Html Msg
viewWishlist products =
    let
        productRow ( product, extensions ) =
            div [ class "row wishlist-item" ]
                [ div [ class "wishlist-item__image-container col-sm-3" ]
                    [ img [ class "wishlist-item__image img-fluid", src product.image_url ] []
                    , span [ class "wishlist-item__rank" ] [ text (toString extensions.rank) ]
                    ]
                , span [ class "wishlist-item__name" ] [ text product.name ]
                , upvoteButton extensions.rank
                , downvoteButton extensions.rank products
                ]
    in
        div [ class "wishlist-container" ] (List.map productRow products)


upvoteButton : Int -> Html Msg
upvoteButton rank =
    -- can't move #1 product up
    if rank > 1 then
        a
            [ class "btn btn-primary"
            , onClick (Up rank)
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
            [ class "btn btn-primary"
            , onClick (Down rank)
            , href "#"
            ]
            [ icon "arrow-down" ]
    else
        text ""
