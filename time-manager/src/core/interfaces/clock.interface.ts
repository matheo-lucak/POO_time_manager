import type {User} from "@/core/interfaces/user.interface";

export interface Clock
{
    time: Date
    status: boolean
    user: User
}
