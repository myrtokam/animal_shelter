"use strict";

const STORAGE_KEY = "shelter-demo-animals-v1";
const CURRENT_YEAR = new Date().getFullYear();

const starterAnimals = [
  { id: 1042, name: "Miso", species: "Cat", breed: "Domestic shorthair", sex: "Female", intakeDate: dateOffset(-2), microchip: "985141000482196", sterilized: true, color: "Tabby", status: "Ready for adoption" },
  { id: 1041, name: "Otis", species: "Dog", breed: "Beagle mix", sex: "Male", intakeDate: dateOffset(-3), microchip: "985141000482182", sterilized: true, color: "Tricolor", status: "In care" },
  { id: 1040, name: "Clover", species: "Rabbit", breed: "Lionhead mix", sex: "Female", intakeDate: dateOffset(-5), microchip: "", sterilized: false, color: "White", status: "Under observation" },
  { id: 1039, name: "Biscuit", species: "Dog", breed: "Terrier mix", sex: "Male", intakeDate: dateOffset(-6), microchip: "985141000482153", sterilized: true, color: "Tan", status: "Ready for adoption" },
  { id: 1038, name: "Juniper", species: "Cat", breed: "Domestic shorthair", sex: "Female", intakeDate: dateOffset(-8), microchip: "985141000482141", sterilized: false, color: "Calico", status: "In care" },
  { id: 1037, name: "Pip", species: "Dog", breed: "Cocker spaniel mix", sex: "Male", intakeDate: dateOffset(-10), microchip: "985141000482130", sterilized: true, color: "Golden", status: "Ready for adoption" },
  { id: 1036, name: "Olive", species: "Cat", breed: "Domestic longhair", sex: "Female", intakeDate: dateOffset(-12), microchip: "985141000482119", sterilized: true, color: "Black", status: "In care" },
  { id: 1035, name: "Maple", species: "Dog", breed: "Labrador mix", sex: "Female", intakeDate: dateOffset(-14), microchip: "985141000482101", sterilized: false, color: "Chocolate", status: "Under observation" }
];

const medicalRecords = [
  { id: 5021, title: "Annual wellness exam", case: `MR-${CURRENT_YEAR}-042`, animalId: 1042, status: "Reviewed", summary: "Healthy · vaccinations up to date", reviewed: dateOffset(-2), priority: "Routine" },
  { id: 5020, title: "Post-operative follow-up", case: `MR-${CURRENT_YEAR}-041`, animalId: 1041, status: "Follow-up", summary: "Recovery progressing as expected", reviewed: dateOffset(-3), priority: "Routine" },
  { id: 5019, title: "Initial health assessment", case: `MR-${CURRENT_YEAR}-040`, animalId: 1040, status: "Open", summary: "Monitoring appetite and hydration", reviewed: dateOffset(-4), priority: "Watch" },
  { id: 5018, title: "Dental check", case: `MR-${CURRENT_YEAR}-039`, animalId: 1039, status: "Reviewed", summary: "No treatment required", reviewed: dateOffset(-6), priority: "Routine" },
  { id: 5017, title: "Skin irritation", case: `MR-${CURRENT_YEAR}-038`, animalId: 1038, status: "Follow-up", summary: "Topical treatment · review in 7 days", reviewed: dateOffset(-7), priority: "Watch" }
];

const appointments = [
  { id: 1, date: dateOffset(0), time: "09:30 AM", animalId: 1041, reason: "Post-op check", vet: "Dr. Elena Ruiz", status: "Scheduled" },
  { id: 2, date: dateOffset(0), time: "11:00 AM", animalId: 1040, reason: "Wellness assessment", vet: "Dr. Sam Patel", status: "Scheduled" },
  { id: 3, date: dateOffset(0), time: "02:15 PM", animalId: 1038, reason: "Skin follow-up", vet: "Dr. Elena Ruiz", status: "Scheduled" },
  { id: 4, date: dateOffset(1), time: "10:00 AM", animalId: 1035, reason: "Vaccination", vet: "Dr. Sam Patel", status: "Scheduled" },
  { id: 5, date: dateOffset(2), time: "01:30 PM", animalId: 1037, reason: "Annual wellness exam", vet: "Dr. Elena Ruiz", status: "Scheduled" }
];

const pageContent = document.querySelector("#page-content");
const navItems = [...document.querySelectorAll(".nav-item")];
let animals = loadAnimals();
let activePage = "dashboard";
let searchQuery = "";
let toastTimer;

function dateOffset(days) {
  const date = new Date();
  date.setHours(12, 0, 0, 0);
  date.setDate(date.getDate() + days);
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
}

function loadAnimals() {
  try {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (!saved) return [...starterAnimals];
    const parsed = JSON.parse(saved);
    return Array.isArray(parsed) ? parsed : [...starterAnimals];
  } catch (error) {
    console.warn("Could not read demo animal data from this browser.", error);
    return [...starterAnimals];
  }
}

function persistAnimals() {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(animals));
    return true;
  } catch (error) {
    console.error("Could not save demo animal data in this browser.", error);
    return false;
  }
}

function escapeHtml(value) {
  return String(value ?? "").replace(/[&<>"']/g, character => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
  })[character]);
}

function icon(name) {
  return `<svg class="icon" aria-hidden="true"><use href="#i-${name}"></use></svg>`;
}

function displayDate(date) {
  if (!date) return "—";
  const parsed = new Date(`${date}T12:00:00`);
  return Number.isNaN(parsed.getTime()) ? "—" : new Intl.DateTimeFormat("en-US", { month: "short", day: "numeric", year: "numeric" }).format(parsed);
}

function initials(name) {
  return String(name || "?").trim().split(/\s+/).slice(0, 2).map(part => part[0]).join("").toUpperCase();
}

function animalById(id) {
  return animals.find(animal => Number(animal.id) === Number(id));
}

function avatarClass(species) {
  if (species === "Cat") return "cat";
  if (species === "Rabbit") return "rabbit";
  return "";
}

function statusClass(status) {
  if (status === "Open" || status === "Under observation" || status === "Watch") return "warning";
  if (status === "Follow-up") return "neutral";
  return "";
}

function heading(kicker, title, subtitle, action = "") {
  return `<div class="page-heading"><div><span class="eyebrow">${kicker}</span><h1>${title}</h1><p class="page-subtitle">${subtitle}</p></div>${action}</div>`;
}

function animalRow(animal) {
  return `<div class="animal-row" role="button" tabindex="0" data-animal-id="${animal.id}" aria-label="View ${escapeHtml(animal.name)}">
    <div class="animal-person"><span class="animal-avatar ${avatarClass(animal.species)}">${escapeHtml(initials(animal.name))}</span><div><div class="animal-name">${escapeHtml(animal.name)}</div><div class="animal-meta">#${animal.id} · ${escapeHtml(animal.breed || animal.species)}</div></div></div>
    <span class="row-secondary">${escapeHtml(animal.species)}</span>
    <span class="row-secondary">${escapeHtml(animal.sex || "Not specified")}</span>
    <span class="status-pill ${statusClass(animal.status)}">${escapeHtml(animal.status || "In care")}</span>
  </div>`;
}

function renderDashboard() {
  const latest = [...animals].sort((a, b) => Number(b.id) - Number(a.id)).slice(0, 5);
  const todayAppointments = appointments.filter(item => item.date === dateOffset(0));
  const todayLabel = new Intl.DateTimeFormat("en-US", { weekday: "long", month: "long", day: "numeric" }).format(new Date()).toUpperCase();
  return `${heading(todayLabel, "Good morning, Myrsini", "Here's what's happening at OKAPI today.", `<button class="button button-primary" data-action="add-animal">${icon("plus")} Add animal</button>`)}
    <section class="stats-grid" aria-label="OKAPI summary">
      <article class="stat-card"><div class="stat-top"><span>Animals in care</span><span class="stat-icon">${icon("paw")}</span></div><div class="stat-value">${animals.length}<span class="stat-trend">active profiles</span></div><div class="stat-footnote">Across all care stages</div></article>
      <article class="stat-card"><div class="stat-top"><span>Open medical records</span><span class="stat-icon amber">${icon("clipboard")}</span></div><div class="stat-value">${medicalRecords.filter(record => record.status === "Open" || record.status === "Follow-up").length}<span class="stat-trend">need attention</span></div><div class="stat-footnote">Follow-ups and active cases</div></article>
      <article class="stat-card"><div class="stat-top"><span>Appointments today</span><span class="stat-icon">${icon("calendar")}</span></div><div class="stat-value">${todayAppointments.length}<span class="stat-trend">${todayAppointments.length === 1 ? "visit today" : "visits today"}</span></div><div class="stat-footnote">${todayAppointments.length ? `Next visit at ${escapeHtml(todayAppointments[0].time)}` : "No visits scheduled today"}</div></article>
      <article class="stat-card"><div class="stat-top"><span>Ready for adoption</span><span class="stat-icon rose">${icon("heart")}</span></div><div class="stat-value">${animals.filter(animal => animal.status === "Ready for adoption").length}<span class="stat-trend">looking for a home</span></div><div class="stat-footnote">Profiles up to date</div></article>
    </section>
    <section class="content-grid">
      <article class="panel">
        <header class="panel-header"><div><h2 class="panel-title">Recently updated animals</h2><span class="panel-kicker">The latest arrivals and care updates</span></div><button class="button button-link" data-page="animals">View all ${icon("arrow")}</button></header>
        <div class="panel-body">${latest.length ? latest.map(animalRow).join("") : `<div class="panel-empty">No animal profiles yet. Add the first one to get started.</div>`}</div>
      </article>
      <div>
        <article class="panel">
          <header class="panel-header"><div><h2 class="panel-title">Today's schedule</h2><span class="panel-kicker">${escapeHtml(new Intl.DateTimeFormat("en-US", { weekday: "long", month: "short", day: "numeric" }).format(new Date()))}</span></div><button class="button button-link" data-page="appointments">Full schedule ${icon("arrow")}</button></header>
          <div class="schedule-list">${todayAppointments.map(item => {
            const animal = animalById(item.animalId);
            return `<div class="schedule-item"><time class="schedule-time">${escapeHtml(item.time.replace(" ", "\u00a0"))}</time><div class="schedule-details ${item.time.includes("11:") ? "amber-line" : ""}"><strong>${escapeHtml(item.reason)}${animal ? ` · ${escapeHtml(animal.name)}` : ""}</strong><span>${escapeHtml(item.vet)}</span></div></div>`;
          }).join("")}</div>
        </article>
        <div class="care-note"><span class="stat-icon amber">${icon("clock")}</span><div><strong>Care team reminder</strong><p>Clover's initial health assessment is open. Remember to record today's appetite check.</p></div></div>
      </div>
    </section>
    <div class="quick-actions"><button class="quick-action" data-action="add-animal">${icon("plus")} Register an animal</button><button class="quick-action" data-page="medical">${icon("clipboard")} Review medical records</button><button class="quick-action" data-page="appointments">${icon("calendar")} View appointments</button></div>`;
}

function renderAnimals() {
  const query = searchQuery.trim().toLowerCase();
  const filtered = animals.filter(animal => [animal.name, animal.species, animal.breed, animal.sex, animal.microchip, animal.status, animal.id].some(value => String(value ?? "").toLowerCase().includes(query)));
  return `${heading("ANIMAL DIRECTORY", "Animals", "Every profile starts with a name, a story, and good care.", `<button class="button button-primary" data-action="add-animal">${icon("plus")} Add animal</button>`)}
    <div class="toolbar"><label class="search-box">${icon("search")}<input id="animal-search" type="search" value="${escapeHtml(searchQuery)}" placeholder="Search by name, species or microchip…" aria-label="Search animals"></label><span class="result-count">${filtered.length} ${filtered.length === 1 ? "animal" : "animals"}</span></div>
    <section class="panel"><div class="data-table-wrap"><table class="data-table"><thead><tr><th>Animal</th><th>Species</th><th>Sex</th><th>Intake date</th><th>Microchip</th><th>Care status</th></tr></thead><tbody>${filtered.length ? filtered.map(animal => `<tr><td><span class="animal-cell"><span class="animal-avatar ${avatarClass(animal.species)}">${escapeHtml(initials(animal.name))}</span>${escapeHtml(animal.name)}</span></td><td>${escapeHtml(animal.species)}</td><td>${escapeHtml(animal.sex || "—")}</td><td>${displayDate(animal.intakeDate)}</td><td>${escapeHtml(animal.microchip || "—")}</td><td><span class="status-pill ${statusClass(animal.status)}">${escapeHtml(animal.status || "In care")}</span></td></tr>`).join("") : `<tr><td colspan="6" class="panel-empty">No animals match your search.</td></tr>`}</tbody></table></div><div class="table-note">${icon("heart")} Sample animal data for the frontend preview. Changes are stored in this browser only.</div></section>`;
}

function renderMedical() {
  return `${heading("HEALTH & WELLBEING", "Medical records", "Clinical notes and follow-ups, kept clear and easy to find.")}
    <div class="toolbar"><label class="search-box">${icon("search")}<input id="medical-search" type="search" value="${escapeHtml(searchQuery)}" placeholder="Search records or animals…" aria-label="Search medical records"></label><span class="result-count">${medicalRecords.length} records</span></div>
    <section class="panel"><header class="panel-header"><div><h2 class="panel-title">Recent records</h2><span class="panel-kicker">A demo view based on your MedicalRecords model</span></div><span class="status-pill">${medicalRecords.filter(record => record.status === "Reviewed").length} reviewed</span></header>
    <div class="records-list" id="records-list">${medicalRecords.map(record => {
      const animal = animalById(record.animalId);
      return `<article class="record-item" data-search="${escapeHtml(`${record.title} ${record.case} ${record.summary} ${animal?.name || ""}`.toLowerCase())}"><div><div class="record-title">${escapeHtml(record.title)}</div><div class="record-ref">${escapeHtml(record.case)}${animal ? ` · ${escapeHtml(animal.name)}` : ""}</div></div><span class="record-summary">${escapeHtml(record.summary)}</span><span class="status-pill ${statusClass(record.status)}">${escapeHtml(record.status)}</span><span class="record-date">${displayDate(record.reviewed)}</span></article>`;
    }).join("")}</div><div class="table-note">${icon("clipboard")} Clinical records shown are sample data; they are not loaded from the database.</div></section>`;
}

function renderAppointments() {
  return `${heading("CARE COORDINATION", "Appointments", "A simple view of the veterinary team's upcoming visits.")}
    <div class="toolbar"><div class="eyebrow">UPCOMING VISITS</div><span class="result-count">${appointments.length} scheduled</span></div>
    <section class="panel"><header class="panel-header"><div><h2 class="panel-title">Appointment schedule</h2><span class="panel-kicker">Organized by date and time</span></div></header>
    <div class="appointment-list">${appointments.map(item => {
      const animal = animalById(item.animalId);
      const date = new Date(`${item.date}T12:00:00`);
      const day = new Intl.DateTimeFormat("en-US", { day: "2-digit" }).format(date);
      const month = new Intl.DateTimeFormat("en-US", { month: "short" }).format(date);
      return `<article class="appointment-item"><div class="date-block"><strong>${day}</strong><span>${month}</span></div><div><div class="appointment-title">${escapeHtml(item.reason)}</div><div class="appointment-subtitle">${animal ? `${escapeHtml(animal.name)} · ${escapeHtml(animal.species)}` : "Animal profile unavailable"}</div></div><div><div class="appointment-title">${escapeHtml(item.time)}</div><div class="appointment-subtitle">${escapeHtml(item.vet)}</div></div><span class="status-pill">${escapeHtml(item.status)}</span></article>`;
    }).join("")}</div><div class="table-note">${icon("calendar")} Example appointments based on your Appointment model; the DAO currently only tests the database connection.</div></section>`;
}

function render() {
  const pages = {
    dashboard: ["Overview", renderDashboard],
    animals: ["Animals", renderAnimals],
    medical: ["Medical records", renderMedical],
    appointments: ["Appointments", renderAppointments]
  };
  const [label, renderer] = pages[activePage] || pages.dashboard;
  document.querySelector("#page-breadcrumb").textContent = label;
  pageContent.innerHTML = renderer();
  navItems.forEach(item => {
    const active = item.dataset.page === activePage;
    item.classList.toggle("is-active", active);
    if (active) item.setAttribute("aria-current", "page");
    else item.removeAttribute("aria-current");
  });
  document.querySelector("#nav-animal-count").textContent = String(animals.length);
  bindSearch();
}

function bindSearch() {
  const animalSearch = document.querySelector("#animal-search");
  if (animalSearch) animalSearch.addEventListener("input", event => {
    const position = event.target.selectionStart;
    searchQuery = event.target.value;
    const scrollPosition = window.scrollY;
    render();
    const replacement = document.querySelector("#animal-search");
    replacement.focus();
    replacement.setSelectionRange(position, position);
    window.scrollTo(0, scrollPosition);
  });
  const medicalSearch = document.querySelector("#medical-search");
  if (medicalSearch) medicalSearch.addEventListener("input", () => {
    const query = medicalSearch.value.trim().toLowerCase();
    document.querySelectorAll(".record-item").forEach(item => {
      item.hidden = !item.dataset.search.includes(query);
    });
  });
}

function navigate(page) {
  activePage = page;
  searchQuery = "";
  document.querySelector("#sidebar").classList.remove("is-open");
  document.querySelector(".mobile-overlay")?.classList.remove("is-visible");
  render();
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function openModal() {
  const modal = document.querySelector("#animal-modal");
  modal.hidden = false;
  document.body.style.overflow = "hidden";
  document.querySelector("#animal-name").focus();
}

function closeModal() {
  document.querySelector("#animal-modal").hidden = true;
  document.body.style.overflow = "";
}

function showToast(message) {
  const toast = document.querySelector("#toast");
  toast.textContent = message;
  toast.classList.add("is-visible");
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => toast.classList.remove("is-visible"), 3200);
}

document.addEventListener("click", event => {
  const pageButton = event.target.closest("[data-page]");
  if (pageButton) {
    event.preventDefault();
    navigate(pageButton.dataset.page);
    return;
  }
  if (event.target.closest('[data-action="add-animal"]')) {
    openModal();
    return;
  }
  const animalElement = event.target.closest("[data-animal-id]");
  if (animalElement) {
    const animal = animalById(animalElement.dataset.animalId);
    if (animal) showToast(`${animal.name} · ${animal.species} · ${animal.status || "In care"} — profile details are part of the upcoming backend integration.`);
  }
});

document.addEventListener("keydown", event => {
  const animalElement = event.target.closest?.("[data-animal-id]");
  if (animalElement && (event.key === "Enter" || event.key === " ")) {
    event.preventDefault();
    animalElement.click();
  }
  if (event.key === "Escape" && !document.querySelector("#animal-modal").hidden) closeModal();
});

document.querySelector("#animal-form").addEventListener("submit", event => {
  event.preventDefault();
  const formData = new FormData(event.currentTarget);
  const name = String(formData.get("name") || "").trim();
  if (!name) return;
  const animal = {
    id: Math.max(1000, ...animals.map(item => Number(item.id) || 0)) + 1,
    name,
    species: String(formData.get("species") || "Other"),
    breed: String(formData.get("breed") || "").trim(),
    sex: String(formData.get("sex") || ""),
    intakeDate: String(formData.get("intakeDate") || new Date().toISOString().slice(0, 10)),
    microchip: String(formData.get("microchip") || "").trim(),
    sterilized: false,
    color: "",
    status: "In care"
  };
  animals = [animal, ...animals];
  const saved = persistAnimals();
  closeModal();
  event.currentTarget.reset();
  navigate("animals");
  showToast(saved
    ? `${name} has been added to the demo animal list.`
    : `${name} was added for this session, but could not be saved in this browser.`);
});

document.querySelector("#close-modal").addEventListener("click", closeModal);
document.querySelector("#cancel-modal").addEventListener("click", closeModal);
document.querySelector("#animal-modal").addEventListener("click", event => {
  if (event.target.id === "animal-modal") closeModal();
});

const overlay = document.createElement("div");
overlay.className = "mobile-overlay";
overlay.addEventListener("click", () => {
  document.querySelector("#sidebar").classList.remove("is-open");
  overlay.classList.remove("is-visible");
});
document.body.append(overlay);
document.querySelector("#menu-button").addEventListener("click", () => {
  document.querySelector("#sidebar").classList.toggle("is-open");
  overlay.classList.toggle("is-visible");
});

render();
