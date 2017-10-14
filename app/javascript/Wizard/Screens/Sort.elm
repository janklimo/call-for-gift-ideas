module Wizard.Screens.Sort exposing (viewSortScreen)

import Html exposing (Html, text, div, h1, h2, span, p, a, img)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (..)
import Utils exposing (onClick)


viewSortScreen : Model -> Html Msg
viewSortScreen model =
    div [ class "card" ]
        [ div [ class "text-center" ]
            [ h1 [] [ text "Any Preferences?" ]
            , p [] [ text "Let's order your wishlist before we're done!" ]
            ]
        , model.products
            |> likedProducts
            |> sortedByRank
            |> viewWishlist
        ]


viewWishlist : Products -> Html Msg
viewWishlist products =
    let
        productRow ( product, extensions ) =
            div [ class "wishlist-item" ]
                [ img [ class "wishlist-item__image", src product.image_url ] []
                , span [ class "wishlist-item__name" ] [ text product.name ]
                , upvoteButton extensions.rank
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
            [ text "Up" ]
    else
        text ""
