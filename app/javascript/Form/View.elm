module Form.View exposing (view)

import Html exposing (Html, div, img, text, a, h1, p)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData(..))
import Form.Models exposing (..)
import Form.Msgs exposing (..)
import Form.Common exposing (valid)


-- Components

import Form.Components.Form exposing (callForm)
import Form.Components.SubmitButton exposing (submitButton)


submitIfValid : Model -> Msg
submitIfValid model =
    if valid model then
        Submit
    else
        Validate


view : Model -> Html Msg
view model =
    case model.requestStatus of
        NotAsked ->
            div []
                [ h1 [ class "text-center" ] [ text ("Let's Do It!") ]
                , callForm model
                , submitButton model (submitIfValid model) False
                ]

        Loading ->
            div []
                [ h1 [ class "text-center" ] [ text ("Let's Do It!") ]
                , callForm model
                , submitButton model (submitIfValid model) True
                ]

        Failure a ->
            div []
                [ h1 [ class "text-center" ] [ text ("Oh Noez") ]
                , p [ class "text-center mb-4" ] [ text "Something went horribly wrong. Try again?" ]
                , submitButton model BackToFormWithoutReset False
                ]

        Success a ->
            div [ class "text-center" ]
                [ h1 [] [ text ("Yeehaaa!") ]
                , img
                    [ src "https://s3-us-west-2.amazonaws.com/callforgiftideas/aw_yiss.png"
                    , class "aw-yiss"
                    ]
                    []
                , p []
                    [ text
                        ("Thank you, "
                            ++ model.senderName
                            ++ "! We've sent an email to "
                            ++ model.recipientName
                            ++ ". You'll receive a notification once they submit their wishlist!"
                        )
                    ]
                , p [ class "mb-4" ] [ text "Ready to send another one?" ]
                , submitButton model BackToFormResetRecipient False
                ]
