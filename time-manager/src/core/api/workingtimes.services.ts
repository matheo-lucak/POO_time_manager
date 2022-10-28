import AxiosServices from "@/core/api/axios.services";
import type { Workingtime } from "@/core/interfaces/workingtime.interface";

export default class WorkingtimesServices extends AxiosServices
{
    public async getWorkingtime(userID: number, id:string) : Promise<Workingtime>
    {
        return this.get(`/workingtimes/${userID}/${id}`, null);
    }

    public async getAllWorkingtime(userId: number) : Promise<Workingtime>
    {
        return this.get(`/workingtimes/${userId}`, {})
    }

    public async postWorkingtime(userID: number) : Promise<Workingtime>
    {
        return this.post(`/workingtimes/${userID}`, null,null);
    }

    public async putWorkingtime(userID: number) : Promise<Workingtime>
    {
        return this.put(`/workingtimes/${userID}`, null, null);
    }

    public async deleteWorkingtime(userID: number) : Promise<Workingtime>
    {
        return this.delete(`/workingtimes/${userID}`, null);
    }

}
