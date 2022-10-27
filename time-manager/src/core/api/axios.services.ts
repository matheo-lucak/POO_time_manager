import axios, { type AxiosInstance, type AxiosRequestConfig } from 'axios'

export default class AxiosServices
{
    private axiosClient: AxiosInstance;

    constructor() {
        this.axiosClient = axios.create({
            baseURL: "http://localhost:4000/api"
        });
    }
    public async get(url: string, queryParams : any) : Promise<any>
    {
        return await this.axiosClient.get(url, queryParams);
    }

    public async post(url: string, body: any, queryParams: any) : Promise<any>
    {
        return await this.axiosClient.post(url, body, queryParams);
    }

    public async put(url: string, body: any, queryParams: any) : Promise<any>
    {
        return await this.axiosClient.put(url, body, queryParams);
    }

    public async delete(url: string, queryParams: any) : Promise<any>
    {
        return await this.axiosClient.delete(url, queryParams);
    }

}

