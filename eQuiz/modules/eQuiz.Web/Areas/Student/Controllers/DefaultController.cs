using eQuiz.Web.Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eQuiz.Web.Areas.Student.Controllers
{
    public class DefaultController : BaseController
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Details()
        {
            return View();
        }

        public ActionResult Dashboard()
        {
            return View();
        }
    }
}