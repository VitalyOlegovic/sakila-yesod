module Handler.ActorHandler where

import Import

getActorListR :: Handler Html
getActorListR = do
    actorList <- runDB $ selectList ([] :: [Filter Actor]) []
    defaultLayout $ do
        --Set the title
        let title = "Actor list" :: String
        setTitle (toHtml title)
        --Set the view to use to show data to the user
        $(widgetFile "actor-list")

getNewActorR :: Handler Html
getNewActorR = do
    -- Just show the actor-new view
    defaultLayout $ do
        $(widgetFile "actor-new")

postCreateActorR :: Handler Html
postCreateActorR = do
    -- Get the request parameters
    firstName <- runInputPost $ ireq textField "firstName"
    lastName <- runInputPost $ ireq textField "lastName"
    -- Get the current time
    now <- liftIO getCurrentTime
    -- Create an actor
    let actor = Actor firstName lastName now
    -- Insert the actor in the database. Discard the result
    _ <- ($) runDB $ insertEntity actor
    getActorListR

getEditActorR :: Handler Html
getEditActorR = do
    -- Get the actor id from the request parameter id
    actorId <- runInputGet $ ireq intField "id"
    -- Try to read from the database the actor with that id
    maybeActor <- runDB $ get $ ActorKey actorId
    case maybeActor of
        -- If the actor is found, show the page to edit it
        Just actor -> defaultLayout $ do
            $(widgetFile "actor-edit")
        -- Otherwise, just show the actor list
        Nothing -> getActorListR
    
postUpdateActorR :: Handler Html
postUpdateActorR = do
    -- Get the parameters from the request
    actorId <- runInputPost $ ireq intField "actorId"
    firstName <- runInputPost $ ireq textField "firstName"
    lastName <- runInputPost $ ireq textField "lastName"
    -- Get the current time
    now <- liftIO getCurrentTime
    -- Create an Actor instance
    let actor = Actor firstName lastName now
    -- Replace the old actor data with the new values
    runDB $ replace (ActorKey actorId) $ actor
    getActorListR

getDeleteActorR :: Handler Html
getDeleteActorR = do
    -- Get the id of the Actor to delete from the request
    actorId <- runInputGet $ ireq intField "id"
    -- Delete the actor
    runDB $ delete (ActorKey actorId)
    getActorListR
