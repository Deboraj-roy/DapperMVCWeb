using DapperMVCDemo.Data.Repository;
using DapperMVCDemo.Domain.Entites;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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
            TempData["success"] = "Here is people data!";
            return View(people);
        }

        // GET: PersonController/Details/5
        public async Task<ActionResult> Details(int id)
        {
            var person = await _personRepository.GetByIdAsync(id);
            TempData["success"] = "Here is your personal data!";
            return View(person);
        }

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
            return View();
        }

        // POST: PersonController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
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
                TempData["success"] = "Person deleted successfully!";
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                TempData["error"] = "Something went wrong!";
                return View();
            }
        }
    }
}
