module Wizard.Screens.Success exposing (viewSuccessScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)


viewSuccessScreen : Model -> Html Msg
viewSuccessScreen model =
    div [ class "card welcome-page" ]
        [ h1 [ class "text-center" ] [ text "Success!" ]
        , div [ class "text-center" ]
            [ p [] [ text "This totally worked 😻" ]
            ]
        ]
