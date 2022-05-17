Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 06:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiEQGWd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiEQGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:22:15 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B8443EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:22:06 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652768523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBxW2DVUy+8QNcdtO89/QtcyH5hyPdLnpk/0R+kk5tc=;
        b=q0m2TGlKJ3rrM2y7AJEDGkFwV7JlRvV9E5J1ZKW9xaGvaI/fHv7H0jwBgtVKO9Dv9FuD/0
        rNEb6Me5RzXRZRhCFlIjoKVtXgrEB1SSRhRHGvcUVO5WQm5+xtxtKQujHoroMWoojL7MMn
        UNqqo4/RpOA+hRnghCqYkmPQhHvhYSk=
Date:   Tue, 17 May 2022 06:22:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <79d0ab0d85ed1e735f52914ed45e1cf2@linux.dev>
Subject: Re: [PATCH v3] sched/rt: fix the case where sched_rt_period_us is
 negative
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220517061812.95276-1-yajun.deng@linux.dev>
References: <20220517061812.95276-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with this version, please ignore it.=0A=0A=0A=0AMay 17=
, 2022 2:18 PM, "Yajun Deng" <yajun.deng@linux.dev> wrote:=0A=0A> The pro=
c_dointvec() is for integer, but sysctl_sched_rt_period is a=0A> unsigned=
 integer, proc_dointvec() would convert negative number into=0A> positive=
 number. So both proc_dointvec() and sched_rt_global_validate()=0A> aren'=
t return error even if we set a negative number.=0A> =0A> Use proc_dointv=
ec_minmax() instead of proc_dointvec() and use extra1=0A> limit the minim=
um value for sched_rt_period_us/sched_rt_runtime_us.=0A> =0A> Make sysctl=
_sched_rt_period integer to match proc_dointvec_minmax().=0A> =0A> v3:=0A=
> - Make sysctl_sched_rt_period integer (Valentin Schneider)=0A> v2:=0A> =
- Remove sched_rr_timeslice_ms related changes (Valentin Schneider)=0A> =
=0A> Fixes: d0b27fa77854 ("sched: rt-group: synchonised bandwidth period"=
)=0A> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A> ---=0A> kernel=
/sched/rt.c | 11 +++++------=0A> 1 file changed, 5 insertions(+), 6 delet=
ions(-)=0A> =0A> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c=0A> i=
ndex 8c9ed9664840..cafc580edbe4 100644=0A> --- a/kernel/sched/rt.c=0A> ++=
+ b/kernel/sched/rt.c=0A> @@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_ba=
ndwidth;=0A> * period over which we measure -rt task CPU usage in us.=0A>=
 * default: 1s=0A> */=0A> -unsigned int sysctl_sched_rt_period =3D 100000=
0;=0A> +int sysctl_sched_rt_period =3D 1000000;=0A> =0A> /*=0A> * part of=
 the period that we allow rt tasks to run in us.=0A> @@ -34,9 +34,10 @@ s=
tatic struct ctl_table sched_rt_sysctls[] =3D {=0A> {=0A> .procname =3D "=
sched_rt_period_us",=0A> .data =3D &sysctl_sched_rt_period,=0A> - .maxlen=
 =3D sizeof(unsigned int),=0A> + .maxlen =3D sizeof(int),=0A> .mode =3D 0=
644,=0A> .proc_handler =3D sched_rt_handler,=0A> + .extra1 =3D SYSCTL_ONE=
,=0A> },=0A> {=0A> .procname =3D "sched_rt_runtime_us",=0A> @@ -44,6 +45,=
7 @@ static struct ctl_table sched_rt_sysctls[] =3D {=0A> .maxlen =3D siz=
eof(int),=0A> .mode =3D 0644,=0A> .proc_handler =3D sched_rt_handler,=0A>=
 + .extra1 =3D SYSCTL_NEG_ONE,=0A> },=0A> {=0A> .procname =3D "sched_rr_t=
imeslice_ms",=0A> @@ -2960,9 +2962,6 @@ static int sched_rt_global_constr=
aints(void)=0A> #ifdef CONFIG_SYSCTL=0A> static int sched_rt_global_valid=
ate(void)=0A> {=0A> - if (sysctl_sched_rt_period <=3D 0)=0A> - return -EI=
NVAL;=0A> -=0A> if ((sysctl_sched_rt_runtime !=3D RUNTIME_INF) &&=0A> ((s=
ysctl_sched_rt_runtime > sysctl_sched_rt_period) ||=0A> ((u64)sysctl_sche=
d_rt_runtime *=0A> @@ -2993,7 +2992,7 @@ static int sched_rt_handler(stru=
ct ctl_table *table, int write, void *buffer,=0A> old_period =3D sysctl_s=
ched_rt_period;=0A> old_runtime =3D sysctl_sched_rt_runtime;=0A> =0A> - r=
et =3D proc_dointvec(table, write, buffer, lenp, ppos);=0A> + ret =3D pro=
c_dointvec_minmax(table, write, buffer, lenp, ppos);=0A> =0A> if (!ret &&=
 write) {=0A> ret =3D sched_rt_global_validate();=0A> -- =0A> 2.25.1
