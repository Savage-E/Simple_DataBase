CREATE TABLE public.lecturers
(
    lect_id serial NOT NULL,
    name character varying(20),
    surname character varying(20),
    email character varying(100),
    CONSTRAINT lecturer_pkey PRIMARY KEY (lect_id)
);

CREATE TABLE public.students
(
    stud_id serial NOT NULL,
    name character varying(20),
    surname character varying(20),
    email character varying(100),
    CONSTRAINT student_pkey PRIMARY KEY (stud_id)
);

CREATE TABLE public.courses
(
    course_id serial NOT NULL,
    name character varying(100),
    description text,
    CONSTRAINT course_pkey PRIMARY KEY (course_id)
);

CREATE TABLE public.enrolled_students
(
    en_stud_id serial NOT NULL,
    stud_id bigint NOT NULL,
    course_id bigint NOT NULL,
    CONSTRAINT enrolled_stud_id PRIMARY KEY (en_stud_id),
    CONSTRAINT stud_fkey FOREIGN KEY (stud_id)
        REFERENCES public.students (stud_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT course_fkey FOREIGN KEY (course_id)
        REFERENCES public.courses (course_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
CREATE TABLE public.subjects
(
    subject_id serial NOT NULL,
    course_id bigint NOT NULL,
    lect_id bigint NOT NULL,
    CONSTRAINT subject_pkey PRIMARY KEY (subject_id),
    CONSTRAINT course_fkey FOREIGN KEY (course_id)
        REFERENCES public.courses (course_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT lecturer_fkey FOREIGN KEY (lect_id)
        REFERENCES public.lecturers (lect_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE public.schedules
(
    schedule_id serial NOT NULL,
    "time" time(6) without time zone,
    date date,
    subject_id bigint NOT NULL,
    CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id),
    CONSTRAINT subject_fkey FOREIGN KEY (subject_id)
    REFERENCES public.subjects (subject_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID

);

CREATE TABLE public.attendance
(
    schedule_id bigint NOT NULL,
    en_stud_id bigint NOT NULL,
    status character varying(15),
    CONSTRAINT schedule_fkey FOREIGN KEY (schedule_id)
        REFERENCES public.schedules (schedule_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT enrolled_student_fkey FOREIGN KEY (en_stud_id)
        REFERENCES public.enrolled_students (en_stud_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE public.hometasks
(
    hometask_id serial NOT NULL,
    deadline_time time(6) without time zone,
    deadline_date date,
    schedule_id bigint NOT NULL,
    description text,
    CONSTRAINT hometask_pkey PRIMARY KEY (hometask_id),
    CONSTRAINT schedule_fkey FOREIGN KEY (schedule_id)
        REFERENCES public.schedules (schedule_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
CREATE TABLE public.marks
(
    en_stud_id bigint NOT NULL,
    hometask_id bigint NOT NULL,
    mark bigint,
    CONSTRAINT en_student_fkey FOREIGN KEY (en_stud_id)
        REFERENCES public.enrolled_students (en_stud_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT hometask_fkey FOREIGN KEY (hometask_id)
        REFERENCES public.hometasks (hometask_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);