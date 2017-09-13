module Wizard.App exposing (..)

import Html exposing (Html, text, div, h1, button, span)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- TYPES


type Page
    = Welcome
    | Cards


type alias Flags =
    { recipientName : String
    }


type alias Model =
    { recipientName : String
    , currentPage : Page
    }


type Msg
    = Navigate Page



-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { recipientName } =
            flags
    in
        ( Model recipientName Welcome, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate page ->
            ( { model | currentPage = page }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


renderScreen : Model -> Html Msg
renderScreen model =
    case model.currentPage of
        Welcome ->
            div [ class "welcome-page" ]
                [ h1
                    []
                    [ text ("Welcome, " ++ model.recipientName ++ "!") ]
                , span [] [ text "This is the welcome screen." ]
                , div
                    []
                    [ button [ onClick (Navigate Cards) ] [ text "Let's Go!" ] ]
                ]

        Cards ->
            div [ class "cards-page" ]
                [ h1
                    []
                    [ text "Anything You'd Like?" ]
                , span [] [ text "This is the cards screen." ]
                , div
                    []
                    [ button [ onClick (Navigate Welcome) ] [ text "Back" ] ]
                ]


view : Model -> Html Msg
view model =
    renderScreen model
