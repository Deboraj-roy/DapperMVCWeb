namespace DapperMVCDemo.Data.DataAccess
{
    public interface ISqlDataAccess 
    {
        Task<IEnumerable<T>> LoadData<T, P>(string spName, P parameters, string connectionStringName = "DefaultDapperDatabase");
        Task SaveData<T>(string spName, T parameters, string connectionStringName = "DefaultDapperDatabase");

    }
}