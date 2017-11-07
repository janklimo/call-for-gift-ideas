module Wizard.Main exposing (..)

-- external modules

import Html exposing (programWithFlags)
import Animation
import Bootstrap.Modal as Modal
import Set exposing (Set)
import RemoteData exposing (RemoteData(..))


-- internal modules

import Wizard.Msgs exposing (..)
import Wizard.View exposing (view)
import Wizard.Models exposing (..)
import Wizard.Update exposing (update)


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
        { slug = slug
        , recipientName = recipient_name
        , currentPage = Welcome
        , products = withDefaultExtensions products
        , cardStyle = initialCardStyle
        , modalState = Modal.hiddenState
        , cardRanksToAnimate = Set.empty
        , cardRankToDelete = 0
        , requestStatus = NotAsked
        }
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
