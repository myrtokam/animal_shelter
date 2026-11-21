"use strict";

// ---- CONFIG: change these before you publish ----
const CONTACT_EMAIL = "hello@example.com";          // TODO: your real email address
const LINKEDIN_URL = "https://www.linkedin.com/";    // TODO: your LinkedIn profile URL

// Mobile navigation
const toggle = document.querySelector(".nav-toggle");
const links = document.querySelector(".nav-links");
if (toggle && links) {
  toggle.addEventListener("click", () => {
    const open = links.classList.toggle("open");
    toggle.setAttribute("aria-expanded", String(open));
  });
  links.addEventListener("click", e => {
    if (e.target.closest("a")) { links.classList.remove("open"); toggle.setAttribute("aria-expanded", "false"); }
  });
}

// Scroll reveal
const items = document.querySelectorAll(".reveal");
if ("IntersectionObserver" in window) {
  const io = new IntersectionObserver(entries => entries.forEach(en => {
    if (en.isIntersecting) { en.target.classList.add("in"); io.unobserve(en.target); }
  }), { threshold: 0.12 });
  items.forEach(el => io.observe(el));
} else items.forEach(el => el.classList.add("in"));

// Placeholders for contact details
document.querySelectorAll("[data-email]").forEach(a => { a.href = `mailto:${CONTACT_EMAIL}`; a.textContent = CONTACT_EMAIL; });
document.querySelectorAll("[data-linkedin]").forEach(a => { a.href = LINKEDIN_URL; });
document.querySelectorAll("[data-year]").forEach(el => { el.textContent = new Date().getFullYear(); });

// Contact form: no backend yet — opens the visitor's mail app or copies the message
const form = document.querySelector("#contact-form");
if (form) {
  const status = document.querySelector("#form-status");
  const build = () => {
    const d = new FormData(form);
    const subject = `[OKAPI] ${d.get("topic")} — ${d.get("name")}`;
    const body = `Name: ${d.get("name")}\nOrganisation: ${d.get("org") || "-"}\nEmail: ${d.get("email")}\nTopic: ${d.get("topic")}\n\n${d.get("message")}`;
    return { subject, body };
  };
  form.addEventListener("submit", e => {
    e.preventDefault();
    const { subject, body } = build();
    window.location.href = `mailto:${CONTACT_EMAIL}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    status.textContent = "Opening your email app… if nothing happens, use “Copy message”.";
  });
  document.querySelector("#copy-message").addEventListener("click", async () => {
    if (!form.reportValidity()) return;
    const { subject, body } = build();
    try {
      await navigator.clipboard.writeText(`Subject: ${subject}\n\n${body}`);
      status.textContent = `Message copied. Paste it into an email to ${CONTACT_EMAIL}.`;
    } catch {
      status.textContent = "Could not copy automatically — please select the text and copy it manually.";
    }
  });
}
