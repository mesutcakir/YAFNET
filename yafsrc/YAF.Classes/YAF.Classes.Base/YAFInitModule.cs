using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace YAF.Classes.Base
{
	/// <summary>
	/// Runs 
	/// </summary>
	public class YafInitModule : System.Web.IHttpModule
	{
		// Emailing thread
		private YAF.Classes.Utils.SendMailThread _sendMailThread = null;

		/// <summary>
		/// Gets ID of board to serve
		/// </summary>
		protected int BoardID
		{
			get
			{
				int boardID;

				// retrieve board id from config, otherwise default is 1
				try { boardID = int.Parse(YAF.Classes.Config.BoardID); }
				catch { boardID = 1; }

				return boardID;
			}
		}


		#region IHttpModule Members

		void System.Web.IHttpModule.Dispose()
		{
			// stop emailing thread if it's not
			if (_sendMailThread != null)
				_sendMailThread.StopThread();
		}


		void System.Web.IHttpModule.Init(System.Web.HttpApplication context)
		{
			try
			{
				// attempt to sync roles. Assumes a perfect world in which this version is completely up to date... which might not be the case.
				YAF.Classes.Utils.RoleMembershipHelper.SyncRoles(BoardID);
				// start the mail sending thread...
				YAF.Classes.Utils.SendMailThread _sendMailThread = new YAF.Classes.Utils.SendMailThread(context);
				// run it for the lifetime of the application... (it checks and sends new e-mail every 10 seconds)
				_sendMailThread.StartThread();
			}
			catch
			{
				// do nothing here--upgrading/DB connectivity issues will be handled in ForumPage.cs
			}
		}

		#endregion
	}
}
