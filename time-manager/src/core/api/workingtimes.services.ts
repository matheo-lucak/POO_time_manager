import AxiosServices from "@/core/api/axios.services";
import type {AxiosResponse} from "axios";
import type {Workingtime} from "@/core/interfaces/workingtime.interface";

export default class WorkingtimesServices extends AxiosServices
{
    public async getWorkingtime(userID: number) : Promise<Workingtime>
    {
        return await this.get(`/users/${userID}`, null);
    }

    public async getAllWorkingtime(email: string | undefined, username: string | undefined) : Promise<Workingtime>
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

    public async postWorkingtime(userID: number) : Promise<Workingtime>
    {
        return await this.post(`/users/${userID}`, null,null);
    }

    public async putWorkingtime(userID: number) : Promise<Workingtime>
    {
        return await this.put(`/users/${userID}`, null, null);
    }

    public async deleteWorkingtime(userID: number) : Promise<Workingtime>
    {
        return await this.delete(`/users/${userID}`, null);
    }

}
