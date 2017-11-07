module Wizard.Components.SubmitButton exposing (submitButton)

-- external modules

import Html exposing (Html, div, text, a, img)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData(..))


-- internal modules

import Utils exposing (onClick)
import Wizard.Models exposing (Model)
import Wizard.Msgs exposing (..)


submitButton : Model -> String -> Html Msg
submitButton model label =
    let
        css =
            case model.requestStatus of
                Loading ->
                    "disabled"

                _ ->
                    ""

        children =
            case model.requestStatus of
                Loading ->
                    img
                        [ src
                            "https://s3-us-west-2.amazonaws.com/callforgiftideas/ripple.gif"
                        , class "ripple"
                        ]
                        []

                _ ->
                    text <| label ++ "  🚀"
    in
        div [ class "text-center mt-3" ]
            [ a
                [ class ("btn btn-primary form-submit " ++ css)
                , onClick SubmitWishlist
                , href "#"
                ]
                [ children ]
            ]
