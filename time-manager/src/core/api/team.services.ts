import AxiosServices from "@/core/api/axios.services";
import type { Team } from "@/core/interfaces/team.interface";

export default class TeamsServices extends AxiosServices
{

    // TODO: implement CRUD team

    public async getTeam(teamId: number) : Promise<Team>
    {
        return this.get(`/teams/${teamId}`, { params: {} });
    }

    public async getAllTeam(email: string | undefined, teamname: string | undefined) : Promise<Team>
    {
        let config : any = {params: {        } };
        if (email)
        {
            config.params.email = email;
        }
        if (teamname)
        {
            config.params.teamname = teamname;
        }
        return this.get(`/teams`, config)
    }

    public async postTeam(teamId: number) : Promise<Team>
    {
        return this.post(`/teams/${teamId}`, null,{});
    }

    public async putTeam(teamId: number) : Promise<Team>
    {
        return this.put(`/teams/${teamId}`, null, {});
    }

    public async deleteTeam(teamId: number) : Promise<Team>
    {
        return this.delete(`/teams/${teamId}`, {});
    }
}
