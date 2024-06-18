using DapperMVCDemo.Data.Repository;
using DapperMVCDemo.Domain.Entites;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace DapperMVCDemo.Web.Controllers
{
    public class PersonController : Controller
    {
        private readonly ILogger<PersonController> _logger;
        private readonly IPersonRepository _personRepository;

        public PersonController(ILogger<PersonController> logger, IPersonRepository personRepository)
        {
            _logger = logger;
            _personRepository = personRepository;
        }

        // GET: PersonController
        public async Task<ActionResult> Index()
        {
            var people = await _personRepository.GetAllAsync();
            //TempData["success"] = "Here is people data!";
            return View(people);
        }

        // GET: PersonController/Details/5
        //public async Task<ActionResult> Details(int id)
        //{
        //    var person = await _personRepository.GetByIdAsync(id);
        //    TempData["success"] = "Here is your personal data!";
        //    return View(person);
        //}

        // GET: PersonController/Create
        public async Task<ActionResult> Create()
        {
            var person = new Person();
            return View(person);
        }

        // POST: PersonController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(Person person)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var addPerson = await _personRepository.AddAsync(person);
                    if (addPerson)
                    {
                        Log.Information("Person added successfully!");
                        TempData["success"] = "Person added successfully!";
                        return RedirectToAction(nameof(Index));
                    }
                    else
                    {
                        TempData["error"] = "Something went wrong!";
                        return View();
                    }
                }
                catch (Exception ex)
                {
                    TempData["error"] = $"Something went wrong!\n{ex.Message}";
                    return View();
                }
            }
            else
            {
                return View(person);
            }
        }

        // GET: PersonController/Edit/5
        public async Task<ActionResult> Edit(int id)
        {
            var person = await _personRepository.GetByIdAsync(id);
            if (person is null)
            { 
                TempData["error"] = "Person Not Found!";
                return View("_NotFoundPartial");

                //return NotFound("The specified person was not found or is missing required information.");
            }
            TempData["success"] = "Here is your personal data!";
            return View(person);
        }

        // POST: PersonController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(Person person)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var updatePerson = await _personRepository.UpdateAsync(person);
                    if (updatePerson)
                    {
                        Log.Information("Person updated successfully!");
                        TempData["success"] = "Person updated successfully!";
                        return RedirectToAction(nameof(Index));
                    }
                    else
                    {
                        TempData["error"] = "Something went wrong!";
                        return View(person);
                    }
                }
                catch
                {
                    TempData["error"] = "Something went wrong!";
                    return View(person);
                }
            }
            else
            {
                return View(person);
            }
        }

        // POST: PersonController/Delete/5
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int id)
        {
            try
            {
                await _personRepository.DeleteAsync(id);
                Log.Information("Person deleted successfully!");
                TempData["warning"] = "Person deleted successfully!";
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                TempData["error"] = "Something went wrong!";
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Search(string searchString)
        {  

            if (string.IsNullOrEmpty(searchString))
            {
                TempData["error"] = "Please enter name! not Blank";
                return View("_NotFoundPartial");
            }
            else
            {
                try
                {
                    var people = await _personRepository.SearchAsync(searchString);
                    if (people.Count() == 0)
                    {
                        Log.Information("Person Not Found!");
                        TempData["error"] = "Person Not Found!";
                        return View("_NotFoundPartial");
                    }
                    Log.Information("Person Search found!");
                    TempData["success"] = "Person Found!";
                    return View(people);
                }
                catch
                {
                    TempData["error"] = "Something went wrong!";
                    return View();
                }
            }
           
        }
    }
}
