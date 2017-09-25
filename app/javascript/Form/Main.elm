module Form.Main exposing (..)

import Html exposing (Html, program, input, div, form, label, text, a)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import RemoteData exposing (RemoteData(..), WebData)
import RemoteData.Http
import Form.Models exposing (..)
import Form.Msgs exposing (..)
import Form.Requests exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    initialModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RecipientName name ->
            { model | recipientName = name } ! []

        RecipientEmail email ->
            { model | recipientEmail = email } ! []

        SenderName name ->
            { model | senderName = name } ! []

        SenderEmail email ->
            { model | senderEmail = email } ! []

        Validate ->
            { model | validating = True } ! []

        Submit ->
            ( { model | requestStatus = Loading }
            , RemoteData.Http.post
                createCallUrl
                HandleCreateCallResponse
                callDecoder
                (callEncoder model)
            )

        HandleCreateCallResponse data ->
            { model | requestStatus = data } ! []


validate : String -> Bool -> String
validate input validating =
    if validating then
        if String.length input > 0 then
            "is-valid"
        else
            "is-invalid"
    else
        ""



-- VIEW


view : Model -> Html Msg
view model =
    Html.form []
        [ div [ class "form-row" ]
            [ div [ class "form-group col-sm-6" ]
                [ label [ for "senderName", class "col-form-label" ] [ text "Your Name" ]
                , input
                    [ type_ "text"
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
                    , id "senderEmail"
                    , class ("form-control " ++ validate model.senderEmail model.validating)
                    , placeholder "Sender Email"
                    , onInput SenderEmail
                    ]
                    []
                ]
            ]
        , div [ class "form-row" ]
            [ div [ class "form-group col-sm-6" ]
                [ label [ for "recipientName", class "col-form-label" ] [ text "Recipient's Name" ]
                , input
                    [ type_ "text"
                    , id "recipientName"
                    , class ("form-control " ++ validate model.recipientName model.validating)
                    , placeholder "Recipient's Name"
                    , onInput RecipientName
                    ]
                    []
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "recipientEmail", class "col-form-label" ] [ text "Recipient's Email" ]
                , input
                    [ type_ "email"
                    , id "recipientEmail"
                    , class ("form-control " ++ validate model.recipientEmail model.validating)
                    , placeholder "Recipient's Email"
                    , onInput RecipientEmail
                    ]
                    []
                ]
            ]
        , div [ class "text-center" ]
            [ a
                [ class "btn btn-primary"
                , onClick (submitIfValid model)
                , href "#"
                ]
                [ text "Let's Go!" ]
            ]
        ]


submitIfValid : Model -> Msg
submitIfValid model =
    if
        String.length model.recipientName
            > 0
            && String.length model.recipientEmail
            > 0
            && String.length model.senderName
            > 0
            && String.length model.senderEmail
            > 0
    then
        Submit
    else
        Validate
