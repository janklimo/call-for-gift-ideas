module Wizard.Screens.Sort exposing (viewSortScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)


viewSortScreen : Model -> Html Msg
viewSortScreen model =
    div [ class "sort-page" ]
        [ div [ class "text-center" ]
            [ h1 [] [ text "Any Preferences?" ]
            , p [] [ text "Let's order your wishlist before we're done!" ]
            ]
        ]
