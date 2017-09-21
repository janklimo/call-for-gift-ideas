module Wizard.Screens.Welcome exposing (viewWelcomeScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)


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
