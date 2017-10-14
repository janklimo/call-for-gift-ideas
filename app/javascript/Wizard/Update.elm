module Wizard.Update exposing (..)

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Utils exposing (likedProductsCount)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate page ->
            { model | currentPage = page } ! []

        Like id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product
                        , { extensions
                            | liked = True
                            , seen = True
                            , rank = likedProductsCount model.products + 1
                          }
                        )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    ! []

        Skip id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product, { extensions | seen = True } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    ! []

        StartAgain ->
            let
                -- set all the seen and not liked products to not seen
                updateProduct ( product, extensions ) =
                    if extensions.seen == True && extensions.liked == False then
                        ( product, { extensions | seen = False } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []

        Up productRank ->
            let
                updateProduct ( product, extensions ) =
                    -- decrease the rank = move the product up
                    if extensions.rank == productRank then
                        ( product, { extensions | rank = extensions.rank - 1 } )
                        -- product that used to be here moves down
                    else if extensions.rank == (productRank - 1) then
                        ( product, { extensions | rank = extensions.rank + 1 } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    ! []
