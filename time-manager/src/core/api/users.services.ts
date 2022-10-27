import AxiosServices from "@/core/api/axios.services";
import type {AxiosResponse} from "axios";
import type {User} from "@/core/interfaces/user.interface";

export default class UsersServices extends AxiosServices
{
    public async getUser(userID: number) : Promise<User>
    {
        return await this.get(`/users/${userID}`, null);
    }

    public async getAllUser(email: string | undefined, username: string | undefined) : Promise<User>
    {
        let queryParams : any = {params: {        } };
        if (email)
        {
            queryParams.params.email = email;
        }
        if (username)
        {
            queryParams.params.username = username;
        }
        return await this.get(`/users`, queryParams)
    }

    public async postUser(userID: number) : Promise<User>
    {
        return await this.post(`/users/${userID}`, null,null);
    }

    public async putUser(userID: number) : Promise<User>
    {
        return await this.put(`/users/${userID}`, null, null);
    }

    public async deleteUser(userID: number) : Promise<User>
    {
        return await this.delete(`/users/${userID}`, null);
    }
}
