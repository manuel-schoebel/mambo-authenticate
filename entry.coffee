Meteor.startup ->
  AccountsEntry =
    settings: {
      i18n: {}
    }

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

    i18n: (key) ->
      if @settings.i18n[key] then return @settings.i18n[key] else return key

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entryValidateSignupCode: (signupCode) ->
      not AccountsEntry.settings.showSignupCode or signupCode is AccountsEntry.settings.signupCode

    accountsCreateUser: (username, email, password) ->
      if username
        Accounts.createUser
          username: username,
          email: email,
          password: password,
          profile: AccountsEntry.settings.defaultProfile || {}
      else
        Accounts.createUser
          email: email
          password: password
          profile: AccountsEntry.settings.defaultProfile || {}
