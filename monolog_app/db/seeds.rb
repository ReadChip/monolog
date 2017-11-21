User.create!(user_id:  "Example User",
             name: "管理ユーザー",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             picture: "thumbnail.png",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)