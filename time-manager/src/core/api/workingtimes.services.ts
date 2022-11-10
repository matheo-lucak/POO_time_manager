import AxiosServices from "@/core/api/axios.services";
import type { Workingtime } from "@/core/interfaces/workingtime.interface";

export default class WorkingtimesServices extends AxiosServices
{
    public async getWorkingtime(userID: string, id: string) : Promise<Workingtime>
    {
        return this.get(`/workingtimes/${userID}/${id}`, { params: {} });
    }

    public async getAllWorkingtime(userId: number) : Promise<Workingtime>
    {
        return this.get(`/workingtimes/${userId}`, {})
    }

    public async getAllWorkingtimesByDate(userId: number, start: string, end: string) : Promise<Workingtime>
    {
        let config: any = { params: { } };
        if(start) {
            config.params.start = start;
        }
        if(end) {
            config.params.end = end;
        }
        return this.get(`/workingtimes/${userId}`, config)
    }

    public async postWorkingtime(userID: string, body: any) : Promise<Workingtime>
    {
        return this.post(`/workingtimes/${userID}`,body ,{ params: {} });
    }

    public async putWorkingtime(id: string, body: any) : Promise<Workingtime>
    {
        return this.put(`/workingtimes/${id}`, body, { params: {} });
    }

    public async deleteWorkingtime(id: string) : Promise<Workingtime>
    {
        return this.delete(`/workingtimes/${id}`, { params: {} });
    }

}
