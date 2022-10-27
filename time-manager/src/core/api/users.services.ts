import AxiosServices from "@/core/api/axios.services";
import type {AxiosResponse} from "axios";
import type {User} from "@/core/interfaces/user.interface";

export default class UsersServices extends AxiosServices
{
    public async getUser(userID: number) : Promise<User>
    {
        return await this.get(`/${userID}`, null);
    }

    public async postUser(userID: number) : Promise<User>
    {
        return await this.post(`/${userID}`, null,null);
    }
}
