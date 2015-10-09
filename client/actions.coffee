Template.actions.helpers
  actions: ->
    Actions.find()
  projects: ->
    projectsA = []
    for projects, i in @projects
      Projects.findOne @projects[i]
