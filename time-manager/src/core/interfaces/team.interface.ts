import type { User } from "./user.interface";

export interface Team {
    id: string,
    members: User[]
}