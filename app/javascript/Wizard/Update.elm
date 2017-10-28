module Wizard.Update exposing (..)

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Utils exposing (..)
import Time exposing (second)
import Animation
import Animation.Messenger
import Set exposing (Set)


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
                { model | products = List.map updateProduct model.products } ! []

        Skip id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product, { extensions | seen = True } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []

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
                    if extensions.rank == productRank then
                        upvote ( product, extensions )
                    else if extensions.rank == (productRank - 1) then
                        downvote ( product, extensions )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []

        Down productRank ->
            let
                updateProduct ( product, extensions ) =
                    if extensions.rank == productRank then
                        downvote ( product, extensions )
                    else if extensions.rank == (productRank + 1) then
                        upvote ( product, extensions )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []

        Animate animMsg ->
            let
                ( newStyle, cmd ) =
                    Animation.Messenger.update animMsg model.cardStyle
            in
                ( { model | cardStyle = newStyle }, cmd )

        FadeInFadeOut msg ->
            ({ model
                | cardStyle =
                    Animation.interrupt
                        [ Animation.toWith
                            (Animation.easing
                                { duration = 0.25 * second
                                , ease = (\x -> x ^ 2)
                                }
                            )
                            [ Animation.opacity 0
                            ]
                        , Animation.Messenger.send msg
                        , Animation.toWith
                            (Animation.easing
                                { duration = 0.25 * second
                                , ease = (\x -> x ^ 2)
                                }
                            )
                            [ Animation.opacity 1
                            ]
                        ]
                        model.cardStyle
             }
                ! []
            )

        SwapCards msg ->
            let
                cardRanksToSwap =
                    case msg of
                        Up rank ->
                            Set.fromList [ rank, rank - 1 ]

                        Down rank ->
                            Set.fromList [ rank, rank + 1 ]

                        _ ->
                            Set.empty
            in
                { model
                    | cardRanksToSwap = cardRanksToSwap
                    , cardStyle =
                        Animation.interrupt
                            [ Animation.toWith
                                (Animation.easing
                                    { duration = 0.25 * second
                                    , ease = (\x -> x ^ 2)
                                    }
                                )
                                [ Animation.opacity 0
                                ]
                            , Animation.Messenger.send msg
                            , Animation.toWith
                                (Animation.easing
                                    { duration = 0.25 * second
                                    , ease = (\x -> x ^ 2)
                                    }
                                )
                                [ Animation.opacity 1
                                ]
                            ]
                            model.cardStyle
                }
                    ! []

        ModalMsg state ->
            { model | modalState = state } ! []
