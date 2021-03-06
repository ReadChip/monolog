User.create!(user_id:  "ExampleUser",
             name: "管理ユーザー",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             picture: "thumbnail.png",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(user_id:  "ojisan",
             name: "マルメターノおじさん",
             email: "sausage@marumetano.ojisan",
             password:              "marumetano",
             password_confirmation: "marumetano",
             picture: "marumetano.jpeg",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

Micropost.create!(content: "ようこそMonologへ！",
                  user_id: 1)
