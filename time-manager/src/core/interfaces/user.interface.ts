import type UsersServices from "@/core/api/users.services";

export interface User
{
    username: string
    email: string
    id: number
    role: string
}

export interface UserStore
{
    user: User;
    connectedAs: User;
    userServices: UsersServices;
}

export interface SelectedUserStore
{
    selectedUser: User;
    userList: User[];
    userServices: UsersServices;
}
