# Script for adding the first user
alias MxPublisher.Repo
alias MxPublisher.Accounts.User

user = Repo.get_by(User, email: "admin@example.com")
unless user do
  changeset = User.registration_changeset(
    %User{},
    %{
      password: "ChangeMe1337",
      password_confirmation: "ChangeMe1337",
      email: "admin@example.com",
      username: "Admin",
    }
  )
  Repo.insert(changeset)
end
