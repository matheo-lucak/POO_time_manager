import type UsersServices from "@/core/api/users.services";

export interface User
{
    username: string
    email: string
    userID: number
    role: string
}

export interface UserStore
{
    user: User
    userServices: UsersServices
}
