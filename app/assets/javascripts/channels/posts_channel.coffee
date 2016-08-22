postsChannelFunctions = () ->

    checkMe = (comment_id, username) ->
      unless $('meta[name=admin]').length > 0 || $("meta[user=#{username}]").length > 0
        $("#comment#{comment_id} .control-panel").remove()
      $("#comment#{comment_id}").removeClass("hidden")

    createComment = (data) ->
      if $('.forum-container-comments').data().id
        $('#comments').append(data.partial)
        checkMe(data.comment.id)

    updateComment = (data) ->
      if $('.forum-container-comments').data().id
        $("#comment#{data.comment.id}").after(data.partial).remove()
        checkMe(data.comment.id)

    destroyComment = (data) ->
      if $('.forum-container-comments').data().id
        $("#comment#{data.comment.id}").remove()
        checkMe(data.comment.id)

    if $('.forum-container-comments').length > 0
      App.posts_channel = App.cable.subscriptions.create {
        channel: "PostsChannel"
      },
      connected: () ->


      disconnected: () ->

      received: (data) ->
        switch data.type
          when "create" then createComment(data)
          when "update" then updateComment(data)
          when "destroy" then destroyComment(data)

$(document).on 'turbolinks:load', postsChannelFunctions
