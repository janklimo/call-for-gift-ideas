module Form.Components.SubmitButton exposing (submitButton)

import Html exposing (Html, div, text, a, img)
import Html.Attributes exposing (..)
import Form.Models exposing (..)
import Form.Msgs exposing (..)
import Form.Common exposing (valid)
import Utils exposing (onClick)


nudgeMessage : Model -> Html Msg
nudgeMessage model =
    if not (valid model) && model.validating then
        div [ class "nudge" ] [ text "All fields are required 😱" ]
    else
        div [] []


type alias Disabled =
    Bool


submitButton : Model -> Msg -> Disabled -> Html Msg
submitButton model msg disabled =
    let
        css =
            if disabled then
                "disabled"
            else
                ""

        children =
            case disabled of
                -- show spinner
                True ->
                    img
                        [ src
                            "https://s3-us-west-2.amazonaws.com/callforgiftideas/ripple.gif"
                        , class "ripple"
                        ]
                        []

                False ->
                    text "Let's Go!  🚀"
    in
        div [ class "text-center mt-3" ]
            [ a
                [ class ("btn btn-primary form-submit " ++ css)
                , onClick msg
                , href "#"
                ]
                [ children ]
            , nudgeMessage model
            ]
