 Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
        after load and cli asks for team, team data is made available.
        In first version of app the teams schedule is pulled based on users input of team
- [x] Pull data from an external source
        first scrape the mlssoccer.com site to build a list of teams and urls
        second parse together a url that points to the individual teams url and schedule page
- [x] Implement both list and detail views
        Initial running of cli app allows for a indexed list of mls teams
        after selecting a team a detailed print of the that teams next game
        is presented. Including teams playing, location, time and date(all scraped from team schedule page)
