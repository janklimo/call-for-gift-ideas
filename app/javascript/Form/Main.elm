module Form.Main exposing (..)

import Html exposing (Html, program, input, div, img, form, label, text, a, h1, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import RemoteData exposing (RemoteData(..))
import Form.Models exposing (..)
import Form.Msgs exposing (..)
import Form.Requests exposing (..)
import Utils exposing (onClick)


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
            , createCallMsg model
            )

        BackToFormWithoutReset ->
            { model
                | requestStatus = NotAsked
                , validating = False
            }
                ! []

        BackToFormResetRecipient ->
            { model
                | requestStatus = NotAsked
                , recipientName = ""
                , recipientEmail = ""
                , validating = False
            }
                ! []

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
            [ div [ class "form-group col-sm-6" ]
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
            , div [ class "form-group col-sm-6" ]
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
            ]
        ]


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
                    div [ class "lds-ripple" ]
                        [ div [] []
                        , div [] []
                        ]

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


nudgeMessage : Model -> Html Msg
nudgeMessage model =
    if not (valid model) && model.validating then
        div [ class "nudge" ] [ text "All fields are required 😱" ]
    else
        div [] []


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


valid : Model -> Bool
valid model =
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
        True
    else
        False


submitIfValid : Model -> Msg
submitIfValid model =
    if valid model then
        Submit
    else
        Validate
