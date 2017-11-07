module Wizard.Screens.Failure exposing (viewFailureScreen)

-- external modules

import Html exposing (Html, text, div, h1, h2, button, span, p, a)
import Html.Attributes exposing (..)


-- internal modules

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Components.SubmitButton exposing (submitButton)


viewFailureScreen : Model -> Html Msg
viewFailureScreen model =
    div [ class "card welcome-page" ]
        [ h1 [ class "text-center" ] [ text ("Oh no :(") ]
        , div [ class "text-center" ]
            [ p [] [ text "Something unexpected happened and your wishlist couldn't be submitted 😞" ]
            , p [] [ text "Let's try that again, shall we?" ]
            , submitButton model "Try Again"
            ]
        ]
