module Wizard.Update exposing (..)

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Utils exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate page ->
            { model | currentPage = page }
                |> withNoCmd

        Like id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product, { extensions | liked = Just True } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    |> withNoCmd

        Skip id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product, { extensions | liked = Just False } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    |> withNoCmd
