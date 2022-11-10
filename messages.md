### User
 - role: "" | "manager" | "super manager"
 - username: string
 - email: string
 - has_many: team_owner_of: [Team.id]
 - has_many: team_member_of: [Team.id]

### Team
 - belongs_to: owner_id: User.id
 - has_many: members_id: [User.id]