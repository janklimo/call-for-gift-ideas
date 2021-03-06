module Wizard.Update exposing (..)

-- external modules

import Time exposing (second)
import Animation
import Animation.Messenger
import Set exposing (Set)
import Bootstrap.Modal as Modal
import RemoteData exposing (RemoteData(..))


-- internal modules

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Utils exposing (..)
import Wizard.Requests exposing (submitWishlistMsg)


fadeInFadeOut : Msg -> Model -> Animation.Messenger.State Msg
fadeInFadeOut msg model =
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
                { model
                    | products = List.map updateProduct model.products
                    , currentPage = Cards
                }
                    ! []

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
                    | cardRanksToAnimate = cardRanksToSwap
                    , cardStyle = fadeInFadeOut msg model
                }
                    ! []

        FadeInFadeOut msg ->
            { model | cardStyle = fadeInFadeOut msg model } ! []

        ToggleModalState state ->
            { model | modalState = state } ! []

        ConfirmDeletion productRank ->
            { model
                | modalState = Modal.visibleState
                , cardRankToDelete = productRank
            }
                ! []

        -- the card to be deleted is set in ConfirmDeletion
        AnimatedDelete ->
            { model
                | cardRanksToAnimate = Set.singleton model.cardRankToDelete
                , modalState = Modal.hiddenState
                , cardStyle = fadeInFadeOut (Delete model.cardRankToDelete) model
            }
                ! []

        HandleSubmitWishlistResponse data ->
            let
                page =
                    case data of
                        RemoteData.Failure a ->
                            Wizard.Msgs.Failure

                        RemoteData.Success a ->
                            Wizard.Msgs.Success

                        _ ->
                            Sort
            in
                { model
                    | requestStatus = data
                    , currentPage = page
                }
                    ! []

        SubmitWishlist ->
            ( { model | requestStatus = Loading }
            , submitWishlistMsg model
            )

        ToggleDescription id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product, { extensions | showingFullDescription = not extensions.showingFullDescription } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []

        -- private messages
        Animate animMsg ->
            let
                ( newStyle, cmd ) =
                    Animation.Messenger.update animMsg model.cardStyle
            in
                ( { model | cardStyle = newStyle }, cmd )

        Delete productRank ->
            let
                -- update ranks of all products below the deleted product
                updateRanks ( product, extensions ) =
                    if extensions.rank == productRank then
                        ( product, { extensions | liked = False } )
                    else if extensions.rank > productRank then
                        ( product, { extensions | rank = extensions.rank - 1 } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateRanks model.products }
                    ! []
