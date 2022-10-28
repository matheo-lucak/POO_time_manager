import type {User} from "@/core/interfaces/user.interface";

export interface Workingtime
{
    start: string
    end: string
    user: User
}

export interface WorkingtimeStore 
{
    workingtimes: Workingtime[]
}
