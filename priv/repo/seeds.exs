alias FutureMadeConcerts.Meta.Cause
alias FutureMadeConcerts.Meta.Genre
alias FutureMadeConcerts.Profiles.NonGovOrg

alias FutureMadeConcerts.Repo


  %Cause {name: "Climate Change",
          description: "Climate Change is about climate",
          info_url: "",
          image_url: "" } |> Repo.insert!()

  %Cause {name: "Anti-Discrimination",
          description: "Racism, gender inequalities and all",
          info_url: "",
          image_url: "" } |> Repo.insert!()

  %Cause {name: "Hunger",
          description: "Hunger is about food",
          info_url: "",
          image_url: "" } |> Repo.insert!()

  %Cause {name: "Disarmament/World Peace",
          description: "It's all about peace",
          info_url: "",
          image_url: "" } |> Repo.insert!()

%NonGovOrg {name: "Green Peace",
                description: "about planet",
                headquarters: "Amsterdam",
        } |> Repo.insert!()
%NonGovOrg {name: "Amnesty International",
                description: "about anti-discrimination",
                headquarters: "somewhere else"} |> Repo.insert!()
