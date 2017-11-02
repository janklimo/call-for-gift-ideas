module Wizard.Main exposing (..)

import Html exposing (programWithFlags)
import Wizard.Msgs exposing (..)
import Wizard.View exposing (view)
import Wizard.Models exposing (..)
import Wizard.Update exposing (update)
import Animation
import Bootstrap.Modal as Modal
import Set exposing (Set)


-- INIT


withDefaultExtensions : List Product -> List ( Product, Extensions )
withDefaultExtensions products =
    List.map (\p -> ( p, defaultExtensions )) products


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { recipient_name, products, slug } =
            flags

        initialCardStyle =
            Animation.style [ Animation.opacity 1.0 ]
    in
        Model slug
            recipient_name
            Welcome
            (withDefaultExtensions products)
            initialCardStyle
            Modal.hiddenState
            Set.empty
            0
            ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.cardStyle ]



-- MAIN


main : Program Flags Model Msg
main =
    programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
