using DapperMVCDemo.Data.DataAccess;
using DapperMVCDemo.Domain.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperMVCDemo.Data.Repository
{
    public class PersonRepository : IPersonRepository
    {
        private readonly ISqlDataAccess _db;
        public PersonRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<bool> AddAsync(Person person)
        {
            try
            {
                await _db.SaveData("sp_Create_Person", new
                {
                    person.Name,
                    person.Email,
                    person.Address
                });
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return false;
            }
        }

        public async Task<bool> DeleteAsync(int id)
        {
            try
            {
                await _db.SaveData("sp_Delete_Person", new { Id = id });
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return false;
            }
        }

        public async Task<IEnumerable<Person?>> GetAllAsync()
        {
            try
            {
                return await _db.LoadData<Person, dynamic>("sp_Get_People", new { });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return Enumerable.Empty<Person>();
            }
        }

        public async Task<Person?> GetByIdAsync(int id)
        {
            try
            {
                IEnumerable<Person> person = await _db.LoadData<Person, dynamic>("sp_Get_Person", new { Id = id });
                return person.FirstOrDefault();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return (Person?)Enumerable.Empty<Person>();
            }

        }

        public async Task<bool> UpdateAsync(Person person)
        {
            try
            {
                await _db.SaveData("sp_Update_Person", person);
                //await _db.SaveData("sp_Update_Person", new { person.Id, person.Name, person.Email, person.Address });
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return false;
            }
        }
    }
}
