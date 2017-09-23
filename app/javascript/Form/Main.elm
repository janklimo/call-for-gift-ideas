module Form.Main exposing (..)

import Html exposing (Html, program, input, div, form, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Wizard.Utils exposing (withNoCmd)


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
    Model "" "" "" ""
        |> withNoCmd



-- MODEL


type alias Model =
    { recipientName : String
    , recipientEmail : String
    , senderName : String
    , senderEmail : String
    }



-- UPDATE


type Msg
    = RecipientName String
    | RecipientEmail String
    | SenderName String
    | SenderEmail String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RecipientName name ->
            { model | recipientName = name }
                |> withNoCmd

        RecipientEmail email ->
            { model | recipientEmail = email }
                |> withNoCmd

        SenderName name ->
            { model | senderName = name }
                |> withNoCmd

        SenderEmail email ->
            { model | senderEmail = email }
                |> withNoCmd



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
                    , class "form-control"
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
                    , class "form-control"
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
                    , class "form-control"
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
                    , class "form-control"
                    , placeholder "Recipient's Email"
                    , onInput RecipientEmail
                    ]
                    []
                ]
            ]
        ]
