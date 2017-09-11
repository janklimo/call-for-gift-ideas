module Main exposing (..)

import Html exposing (..)
import Basics exposing (toString)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { currentPage : Page }



-- INIT


model : Model
model =
    Model Welcome



-- MESSAGE


type Msg
    = Navigate Page



-- PAGES


type Page
    = Welcome
    | Cards



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Navigate target ->
            { model | currentPage = target }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- VIEW


renderScreen : Page -> Html Msg
renderScreen page =
    case page of
        Welcome ->
            div [ class "welcome-page" ]
                [ h1
                    []
                    [ text "Welcome!" ]
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
    renderScreen model.currentPage
