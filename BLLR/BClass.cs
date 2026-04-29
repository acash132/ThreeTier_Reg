using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ThreeTier_Reg
{
    public class BClass
    {
        DClass dal = new DClass();

        public int RegisterUser(string fn, string ln, string mob, string pwd, string gen, string email, string hobbies, string dob)
        {
            string query = "INSERT INTO UserProfiles (FirstName, LastName, Mobile, [Password], Gender, Email, Hobbies, DOB) VALUES (@FN, @LN, @Mob, @Pwd, @Gen, @Email, @Hobbies, @DOB)";
            return dal.ExecuteNonQuery(query, GetParams(fn, ln, mob, pwd, gen, email, hobbies, dob));
        }

        public int UpdateUser(string fn, string ln, string mob, string pwd, string gen, string email, string hobbies, string dob)
        {
            string query = "UPDATE UserProfiles SET FirstName=@FN, LastName=@LN, [Password]=@Pwd, Gender=@Gen, Email=@Email, Hobbies=@Hobbies, DOB=@DOB WHERE Mobile=@Mob";
            return dal.ExecuteNonQuery(query, GetParams(fn, ln, mob, pwd, gen, email, hobbies, dob));
        }

        public int DeleteUser(string mobile)
        {
            string query = "DELETE FROM UserProfiles WHERE Mobile = @Mob";
            SqlParameter[] p = { new SqlParameter("@Mob", mobile) };
            return dal.ExecuteNonQuery(query, p);
        }

        public DataTable GetUserByMobile(string mobile)
        {
            string query = "SELECT * FROM UserProfiles WHERE Mobile = @Mob";
            SqlParameter[] p = { new SqlParameter("@Mob", mobile) };
            return dal.GetDataTable(query, p);
        }

        public DataTable GetAllUsers()
        {
            return dal.GetDataTable("SELECT * FROM UserProfiles ORDER BY UserID DESC");
        }

        public bool IsEmailUnique(string email)
        {
            string query = "SELECT COUNT(*) FROM UserProfiles WHERE Email = @Email";
            SqlParameter[] p = { new SqlParameter("@Email", email) };
            int count = (int)dal.ExecuteScalar(query, p);
            return count == 0;
        }

        // Private helper to avoid repeating parameter creation for Insert and Update
        private SqlParameter[] GetParams(string fn, string ln, string mob, string pwd, string gen, string email, string hobbies, string dob)
        {
            return new SqlParameter[] {
                new SqlParameter("@FN", fn),
                new SqlParameter("@LN", ln),
                new SqlParameter("@Mob", mob),
                new SqlParameter("@Pwd", pwd),
                new SqlParameter("@Gen", gen),
                new SqlParameter("@Email", email),
                new SqlParameter("@Hobbies", hobbies),
                new SqlParameter("@DOB", dob)
            };
        }
    }
}
