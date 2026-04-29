using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThreeTier_Reg
{
    public partial class Reg : System.Web.UI.Page
    {
        BClass bll = new BClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { PopulateDateDropdowns(); }
        }

        // --- CREATE ---
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int res = bll.RegisterUser(txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtMobile.Text.Trim(),
                                      txtPassword.Text, GetGender(), txtEmail.Text.Trim(), GetHobbies(), GetDOB());
            ShowMessage(res > 0 ? "Registration Successful!" : "Registration Failed.", res > 0);
            if (res > 0) ClearForm();
        }

        // --- READ (FETCH) ---
        protected void btnFetch_Click(object sender, EventArgs e)
        {
            DataTable dt = bll.GetUserByMobile(txtMobile.Text.Trim());
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                txtFirstName.Text = row["FirstName"].ToString();
                txtLastName.Text = row["LastName"].ToString();
                txtEmail.Text = row["Email"].ToString();
                rbMale.Checked = row["Gender"].ToString() == "Male";
                rbFemale.Checked = row["Gender"].ToString() == "Female";
                // Set Hobbies and DOB logic here...
                gvUserInfo.DataSource = dt;
                gvUserInfo.DataBind();
                ShowMessage("User Found!", true);
            }
            else { ShowMessage("User Not Found.", false); }
        }

        // --- UPDATE ---
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int res = bll.UpdateUser(txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtMobile.Text.Trim(),
                                    txtPassword.Text, GetGender(), txtEmail.Text.Trim(), GetHobbies(), GetDOB());
            ShowMessage(res > 0 ? "Update Successful!" : "Update Failed.", res > 0);
        }

        // --- DELETE ---
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int res = bll.DeleteUser(txtMobile.Text.Trim());
            if (res > 0) { ShowMessage("User Deleted.", true); ClearForm(); }
            else { ShowMessage("Delete Failed.", false); }
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {
            gvUserInfo.DataSource = bll.GetAllUsers();
            gvUserInfo.DataBind();
        }

        // --- VALIDATION ---
        protected void cvEmailUnique_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = bll.IsEmailUnique(args.Value);
        }

        // --- UI HELPERS ---
        private string GetHobbies()
        {
            List<string> list = new List<string>();
            if (chkCricket.Checked) list.Add("Cricket");
            if (chkMusic.Checked) list.Add("Music");
            if (chkReading.Checked) list.Add("Reading");
            return string.Join(", ", list);
        }

        private string GetDOB() => $"{ddlYear.SelectedValue}-{ddlMonth.SelectedValue}-{ddlDay.SelectedValue}";
        private string GetGender() => rbMale.Checked ? "Male" : "Female";

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblDisplay.Text = msg;
            lblDisplay.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }

        private void PopulateDateDropdowns()
        {
            for (int i = 1; i <= 31; i++) ddlDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
            for (int i = DateTime.Now.Year; i >= 1950; i--) ddlYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }

        protected void btnReset_Click(object sender, EventArgs e) { ClearForm(); }
        protected void cvGender_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if either radio button is checked
            args.IsValid = rbMale.Checked || rbFemale.Checked;
        }
        private void ClearForm()
        {
            txtFirstName.Text = txtLastName.Text = txtMobile.Text = txtEmail.Text = txtPassword.Text = txtConfirmPassword.Text = "";
            chkCricket.Checked = chkMusic.Checked = chkReading.Checked = false;
            rbMale.Checked = true; rbFemale.Checked = false;
            ddlDay.SelectedIndex = ddlMonth.SelectedIndex = ddlYear.SelectedIndex = 0;
            gvUserInfo.DataSource = null; gvUserInfo.DataBind();
        }
    }
}