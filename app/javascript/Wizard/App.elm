module Wizard.App exposing (..)

import Html exposing (Html, text, div, h1, button, span, p, a)
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
                    [ class "text-center" ]
                    [ text ("Hey, " ++ model.recipientName ++ "!") ]
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

        Cards ->
            div [ class "cards-page" ]
                [ h1
                    []
                    [ text "Anything You'd Like?" ]
                , p [] [ text "This is the cards screen." ]
                , a
                    [ class "btn btn-primary"
                    , onClick (Navigate Welcome)
                    , href "#"
                    ]
                    [ text "Back" ]
                ]


view : Model -> Html Msg
view model =
    renderScreen model
