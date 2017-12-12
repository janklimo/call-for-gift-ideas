module Form.Components.Form exposing (callForm)

import Html
    exposing
        ( Html
        , input
        , div
        , form
        , label
        , text
        , a
        , h1
        , p
        , span
        , select
        , option
        )
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Form.Models exposing (..)
import Form.Msgs exposing (..)


validate : String -> Bool -> String
validate input validating =
    if validating then
        if String.length input > 0 then
            "is-valid"
        else
            "is-invalid"
    else
        ""


callForm : Model -> Html Msg
callForm model =
    Html.form []
        [ div [ class "form-row" ]
            [ div [ class "form-group col-sm-6" ]
                [ label [ for "senderName", class "col-form-label" ] [ text "Your Name" ]
                , input
                    [ type_ "text"
                    , value model.senderName
                    , id "senderName"
                    , class ("form-control " ++ validate model.senderName model.validating)
                    , placeholder "Your Name"
                    , onInput SenderName
                    ]
                    []
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "senderEmail", class "col-form-label" ] [ text "Your Email" ]
                , input
                    [ type_ "email"
                    , value model.senderEmail
                    , id "senderEmail"
                    , class ("form-control " ++ validate model.senderEmail model.validating)
                    , placeholder "Sender Email"
                    , onInput SenderEmail
                    ]
                    []
                ]
            ]
        , div [ class "form-row" ]
            [ p [ class "disclaimer" ]
                [ text "Your info will "
                , span [ class "never" ] [ text "never" ]
                , text " be shared with the recipient. It's only used to deliver you their wishlist."
                ]
            ]
        , div [ class "form-row" ]
            [ div [ class "form-group col-sm-4" ]
                [ label [ for "recipientName", class "col-form-label" ] [ text "Recipient's Name" ]
                , input
                    [ type_ "text"
                    , value model.recipientName
                    , id "recipientName"
                    , class ("form-control " ++ validate model.recipientName model.validating)
                    , placeholder "Recipient's Name"
                    , onInput RecipientName
                    ]
                    []
                ]
            , div [ class "form-group col-sm-5" ]
                [ label [ for "recipientEmail", class "col-form-label" ] [ text "Recipient's Email" ]
                , input
                    [ type_ "email"
                    , value model.recipientEmail
                    , id "recipientEmail"
                    , class ("form-control " ++ validate model.recipientEmail model.validating)
                    , placeholder "Recipient's Email"
                    , onInput RecipientEmail
                    ]
                    []
                ]
            , div [ class "form-group col-sm-3" ]
                [ label [ for "recipientSex", class "col-form-label" ] [ text "Recipient's Gender" ]
                , select
                    [ class ("form-control " ++ validate model.recipientSex model.validating)
                    , id "recipientSex"
                    , onInput RecipientSex
                    ]
                    [ option [ value "male" ] [ text "Male 👨" ]
                    , option [ value "female" ] [ text "Female 👩" ]
                    ]
                ]
            ]
        ]
